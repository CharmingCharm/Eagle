from django.shortcuts import render, redirect
from user.models import User, Student
from .models import Course
from submission.models import SubmissionItem
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
    memNum = course.member.count()
    # stuNum = course.member.filter(field='student').count()
    submissionItem = SubmissionItem.objects.filter(course=course_id).order_by('id')
    msg = ['no_msg']

    # Check if team forming.
    if course.form_method == (1 or 3 or 5):
        course_stu_form_flag = 1

    for message in messages.get_messages(request):
        msg.append(message)
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
    print(user_list)
    if request.method == 'POST':
        initial_pwd_form = GenerateStudentsForm(request.POST)
        if initial_pwd_form.is_valid():
            initial_pwd = initial_pwd_form.cleaned_data['initial_pwd']
            user_list = request.session.pop('user_list')
            while len(user_list) > 0:
                curr_user = user_list.pop()
                user = User.objects.create_user(username=curr_user['user_name'], password=initial_pwd, email=curr_user['email'], field='student')
                user.save()
                student = Student.objects.create(studentID=str(curr_user['stu_id']), GPA=curr_user['GPA'], user=user)
                student.save()
                course.member.add(user)
            msg = 'Import students success!'
    memNum = course.member.count()
    return render(request, 'generate_student.html', locals())


def import_student_excel(request, course_id):
    course = Course.objects.get(id=course_id)
    msg = "no_msg"
    print(request.session.get('user_list'))
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
                        temp_curr_stu = {'user_name': row_values[0], 'stu_id': str(int(row_values[1])), 'email': row_values[2], 'GPA': row_values[3]}
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
            temp_user['user_name'] = inidividual_form.cleaned_data['user_name']
            temp_user['stu_id'] = inidividual_form.cleaned_data['stu_id']
            temp_user['email'] = inidividual_form.cleaned_data['email']
            temp_user['GPA'] = inidividual_form.cleaned_data['GPA']

            if Student.objects.filter(studentID=temp_user['stu_id']).first() is None:
                request.session['temp_user'] = temp_user
                return redirect('/course/'+ str(course.id) + '/generate_student')
    inidividual_form = ImportIndividualForm()
    return render(request, 'import_student_individual.html', locals())


def export_contribution(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    return render(request, 'export_contribution.html', locals())