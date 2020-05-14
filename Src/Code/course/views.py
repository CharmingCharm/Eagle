from django.http import HttpResponse
from django.shortcuts import render, redirect
from user.models import User, Student
from .models import Course, ExportFile
from submission.models import LeaderAssessment
from team.models import Team
from submission.models import SubmissionItem, SubmissionContribution
from .forms import ImportIndividualForm, GenerateStudentsForm
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator
from django.core import serializers
from django.contrib import messages
from django.db import transaction
import xlrd

def clean_session(request):
    if request.session.get("deleteId") is not None:
        request.session.pop("deleteId")
    if request.session.get("addSubmission") is not None:
        request.session.pop("addSubmission")
    if request.session.get("newSubmission") is not None:
        request.session.pop("newSubmission")
    if request.session.get('user_list') is not None:
        request.session.pop('user_list')

@csrf_exempt
def course_page(request, course_id):
    user = User.objects.get(id=request.user.id)
    course = Course.objects.get(id=course_id)
    course_stu_form_flag = 0
    teachers = course.member.filter(field='teacher')
    team = Team.objects.filter(course=course, member=request.user.id).first()
    teamNum = Team.objects.filter(course=course).count()
    memNum = course.member.count()
    clean_session(request)
    submissionItem = SubmissionItem.objects.filter(course=course_id).order_by('id')
    course_msg = ['no_msg']
    if request.session.get('course_msg') is not None:
        course_msg.append(request.session.get('course_msg'))
        request.session.pop('course_msg')

    # Check if team forming.
    if course.form_method == (1 or 3 or 5):
        course_stu_form_flag = 1

    for message in messages.get_messages(request):
        course_msg.append(message)
    p = Paginator(submissionItem, 5)
    if p.num_pages <= 1:
        submissionItem_list = submissionItem
        data = ''
    else:
        page = int(request.GET.get('page', 1))
        submissionItem_list = p.page(page)
        left = []
        right = []
        left_has_more = False
        right_has_more = False
        first = False
        last = False
        total_pages = p.num_pages
        page_range = p.page_range
        if page == 1:
            right = page_range[page:page + 2]
            if right[-1] < total_pages - 1:
                right_has_more = True
            if right[-1] < total_pages:
                last = True
        elif page == total_pages:
            left = page_range[(page - 3) if (page - 3) > 0 else 0:page - 1]
            if left[0] > 2:
                left_has_more = True
            if left[0] > 1:
                first = True
        else:
            left = page_range[(page - 3) if (page - 3) > 0 else 0:page - 1]
            right = page_range[page:page + 2]
            if left[0] > 2:
                left_has_more = True
            if left[0] > 1:
                first = True
            if right[-1] < total_pages - 1:
                right_has_more = True
            if right[-1] < total_pages:
                last = True
        data = {
            'left': left,
            'right': right,
            'left_has_more': left_has_more,
            'right_has_more': right_has_more,
            'first': first,
            'last': last,
            'total_pages': total_pages,
            'page': page
        }
    return render(request, 'course.html', locals())


def generate_student(request, course_id):
    course = Course.objects.get(id=course_id)
    memNum = course.member.count()
    user_list = []
    msg = 'no_msg'
    initial_pwd_form = GenerateStudentsForm()
    
    if request.session.get('user_list') is not None:
        user_list = request.session.get('user_list')

    if request.session.get('temp_user') is not None:
        temp_stu = request.session['temp_user']
        for curr_user in user_list:
            if curr_user['stu_id'] == temp_stu['stu_id']:
                msg = 'Repeated student!'
                return render(request, 'generate_student.html', locals())
        user_list.append(request.session.pop('temp_user'))
        msg = 'Add successfully!'
        request.session['user_list'] = user_list

    if request.session.get('temp_stu_excel') is not None:
        temp_stu_excel = request.session.get('temp_stu_excel')
        success_num = 0
        fail_num = 0
        for temp_curr_stu in temp_stu_excel:
            flag = 0
            for curr_user in user_list:
                if curr_user['stu_id'] == temp_curr_stu['stu_id']:
                    flag = 1
                    fail_num = fail_num + 1
                    break
            if flag == 0:
                success_num = success_num + 1
                user_list.append(temp_curr_stu)
        msg = 'Add ' + str(success_num) + ' students successfully and ' + str(fail_num) + ' students fail!'
        request.session.pop('temp_stu_excel')
        request.session['user_list'] = user_list
        
    if request.method == 'POST':
        initial_pwd_form = GenerateStudentsForm(request.POST)
        if initial_pwd_form.is_valid():
            initial_pwd = initial_pwd_form.cleaned_data['initial_pwd']
            user_list = request.session.pop('user_list')
            while len(user_list) > 0:
                curr_user = user_list.pop()
                if User.objects.get(username=curr_user['user_name']) is None:
                    user = User.objects.create_user(username=curr_user['user_name'] ,truename=curr_user['true_name'], password=initial_pwd, email=curr_user['email'], field='student')
                    user.save()
                else:
                    continue
                student = Student.objects.create(studentID=str(curr_user['stu_id']), GPA=curr_user['GPA'], user=user)
                student.save()
                course.member.add(user)
            msg = 'Import students success!'
    memNum = course.member.count()
    return render(request, 'generate_student.html', locals())


def import_student_excel(request, course_id):
    course = Course.objects.get(id=course_id)
    msg = "no_msg"
    
    if request.method == 'POST':

        if len(request.FILES) != 0:
            excel_file = request.FILES.get('excel_file', '')
            file_type = excel_file.name.split('.')[1]

            # https://blog.csdn.net/qq_42571805/article/details/89057331

            if file_type in ['xlsx']:
                data = xlrd.open_workbook(filename=None, file_contents=excel_file.read())
                tables = data.sheets()
                temp_stu = []
                for table in tables:
                    rows = table.nrows

                    for row in range(1, rows):
                        row_values = table.row_values(row)
                        split_email = row_values[2].split("@")
                        user_name = split_email[0]
                        if type(row_values[1]) == float:
                            temp_curr_stu = {'user_name': user_name, 'true_name': row_values[0], 'stu_id': str(int(row_values[1])), 'email': row_values[2], 'GPA': row_values[3]}
                        else:
                            temp_curr_stu = {'user_name': user_name, 'true_name': row_values[0], 'stu_id': str(row_values[1]), 'email': row_values[2], 'GPA': row_values[3]}
                        if Student.objects.filter(studentID=temp_curr_stu['stu_id']).first() is None:
                            temp_stu.append(temp_curr_stu)
                request.session['temp_stu_excel'] = temp_stu
                msg = 'success'
                return redirect('/course/' + str(course.id) + '/generate_student')
            else:
                msg = "Wrong file!"
                return render(request, 'import_student_excel.html', locals())
    return render(request, 'import_student_excel.html', locals())


def import_student_individual(request, course_id):
    course = Course.objects.get(id=course_id)
    if request.method == 'POST':
        inidividual_form = ImportIndividualForm(request.POST)
        if inidividual_form.is_valid():
            temp_user = {}
            temp_user['true_name'] = inidividual_form.cleaned_data['true_name']
            temp_user['stu_id'] = inidividual_form.cleaned_data['stu_id']
            temp_user['email'] = inidividual_form.cleaned_data['email']
            temp_user['GPA'] = inidividual_form.cleaned_data['GPA']
            split_email = temp_user['email'].split("@")
            temp_user['user_name'] = split_email[0]

            if Student.objects.filter(studentID=temp_user['stu_id']).first() is None:
                request.session['temp_user'] = temp_user
                return redirect('/course/'+ str(course.id) + '/generate_student')
    inidividual_form = ImportIndividualForm()
    return render(request, 'import_student_individual.html', locals())


def export_contribution(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    students = User.objects.filter(course=course, field='student')
    submissions = SubmissionItem.objects.filter(course=course)
    contribution = 0
    total_bonus_mark = 0
    IsCalculate = request.session.get('IsCalculate')
    if IsCalculate is None:
        for one in students:
            for one_submission in submissions:
                one_submission_contribution = SubmissionContribution.objects.filter(submission=one_submission, member=one).first()
                if one_submission_contribution is None:
                    contribution = -1
                    break
                else:
                    contribution += one_submission_contribution.value * one_submission.percentage * 0.01

            team = Team.objects.filter(course=course, member=one).first()
            if team is None:
                print('Someone still not in a team!')
                contribution = -2
                bonus = -2
            else:
                if team.leader == one.id:
                    for each_member in team.member.all():
                        if team.leader == each_member.id:
                            continue
                        else:
                            leaderBonus = LeaderAssessment.objects.filter(leader=team.leader, member=each_member.id, team=team).first()
                            if leaderBonus is None:
                                bonus = -1
                                break
                            else:
                                total_bonus_mark += leaderBonus.mark
                    if bonus != -1:
                        bonus = total_bonus_mark/(team.member.count()-1)
            export = ExportFile.objects.create(student=one, course=course, contribution=contribution, bonus=bonus)
            contribution = 0
            total_bonus_mark = 0
            IsCalculate = 'true'
            request.session['IsCalculate'] = IsCalculate
            export.save()

    export_display = ExportFile.objects.filter(course=course)
    return render(request, 'export_contribution.html', locals())

#     response = HttpResponse(content_type='application/vnd.ms-excel')
#     response['Content-Disposition'] = 'attachment;filename='+ course.name +'.xls'
#
# # 导出Excel文件
# def export_excel(request):
#     city = request.POST.get('city')
#     print(city)
#     list_obj=place.objects.filter(city=city)
#     # 设置HTTPResponse的类型
#
#     """导出excel表"""
#     if list_obj:
#         # 创建工作簿
#         ws = xlwt.Workbook(encoding='utf-8')
#         # 添加第一页数据表
#         w = ws.add_sheet('sheet1')  # 新建sheet（sheet的名称为"sheet1"）
#         # 写入表头
#         w.write(0, 0, u'地名')
#         w.write(0, 1, u'次数')
#         w.write(0, 2, u'经度')
#         w.write(0, 3, u'纬度')
#         # 写入数据
#         excel_row = 1
#         for obj in list_obj:
#             name = obj.place
#             sum = obj.sum
#             lng = obj.lng
#             lat = obj.lat
#             # 写入每一行对应的数据
#             w.write(excel_row, 0, name)
#             w.write(excel_row, 1, sum)
#             w.write(excel_row, 2, lng)
#             w.write(excel_row, 3, lat)
#             excel_row += 1
#         # 写出到IO
#         output = BytesIO()
#         ws.save(output)
#         # 重新定位到开始
#         output.seek(0)
#         response.write(output.getvalue())
#     return response