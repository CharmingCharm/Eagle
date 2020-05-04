from django.shortcuts import render, redirect
from user.models import User, Student
from .models import Course
from submission.models import SubmissionItem
from .forms import ImportIndividualForm, GenerateStudentsForm
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator
from django.core import serializers

@csrf_exempt
def course_page(request, course_id):
    user = User.objects.get(id=request.user.id)
    course = Course.objects.get(id=course_id)
    teachers = course.member.filter(field='teacher')
    memNum = course.member.count()
    # stuNum = course.member.filter(field='student').count()
    submissionItem = SubmissionItem.objects.filter(course=course_id).order_by('id')

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
    if request.method == 'POST':
        initial_pwd_form = GenerateStudentsForm(request.POST)
        if initial_pwd_form.is_valid():
            initial_pwd = initial_pwd_form.cleaned_data['initial_pwd']
            user_list = request.session.pop('user_list')
            while len(user_list) > 0:
                curr_user = user_list.pop()
                user = User.objects.create_user(username=curr_user['user_name'], password=initial_pwd, email=curr_user['email'], field='student')
                user.save()
                student = Student.objects.create(studentID=curr_user['stu_id'], GPA=curr_user['GPA'], user=user)
                student.save()
                course.member.add(user)
            msg = 'Import students success!'
    memNum = course.member.count()
    return render(request, 'generate_student.html', locals())


def import_student_excel(request, course_id):
    course = Course.objects.get(id=course_id)
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
                return redirect('/course/'+ str(course.id) +'/generate_student')

    inidividual_form = ImportIndividualForm()
    return render(request, 'import_student_individual.html', locals())