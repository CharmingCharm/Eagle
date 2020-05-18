from .models import User
from django.contrib.auth import authenticate, logout, login
from django.shortcuts import render, redirect
from django.contrib import messages
from .forms import LoginForm, RegisterForm, ChangePasswordForm
from course.models import Course
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator

def clean_session(request):
    if request.session.get("deleteId") is not None:
        request.session.pop("deleteId")
    if request.session.get("addSubmission") is not None:
        request.session.pop("addSubmission")
    if request.session.get("newSubmission") is not None:
        request.session.pop("newSubmission")
    if request.session.get('user_list') is not None:
        request.session.pop('user_list')

def index(request):
    return redirect('/student_home/')

def login_self(request):
    clean_session(request)
    if request.user.is_authenticated:
        return redirect('/')
    if request.method == 'POST':
        login_form = LoginForm(request.POST)
        if login_form.is_valid():
            username = login_form.cleaned_data['username']
            password = login_form.cleaned_data['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                if User.objects.get(id=request.user.id).field == 'student':
                    return redirect('/student_home/')
                elif User.objects.get(id=request.user.id).field == 'teacher':
                    return redirect('/teacher_home/')
                else:
                    return redirect('/')
            messages.add_message(request, messages.ERROR, 'Username does not exist or password is wrong!')
        return render(request, 'login.html', locals())
    login_form = LoginForm()
    return render(request, 'login.html', locals())

def register(request):
    clean_session(request)
    if request.user.is_authenticated:
        return redirect('/')
    if request.method == 'POST':
        register_form = RegisterForm(request.POST)
        if register_form.is_valid():
            username = register_form.cleaned_data['username']
            password = register_form.cleaned_data['password']
            # confirm_password = register_form.cleaned_data['confirm_password']
            email = register_form.cleaned_data['email']
            # if password != confirm_password:
            #     messages.add_message(request, messages.ERROR, 'Your confirm password is different from your password!')
            #     return render(request, 'register.html', locals())
            # else:
            user_obj = User.objects.filter(username=username).first()
            if not user_obj:
                user = User.objects.create_user(username=username, password=password, email=email)
                user.save()
                messages.add_message(request, messages.SUCCESS, 'Register succeed, please Login!')
                return redirect('/login/')
            messages.add_message(request, messages.ERROR, 'Username already exists!')
            return render(request, 'register.html', locals())
    register_form = RegisterForm()
    return render(request, 'register.html', locals())


def logout_self(request):
    logout(request)
    clean_session(request)
    messages.add_message(request, messages.SUCCESS, 'Logout successfully.')
    return redirect("/login/")


@csrf_exempt
def student_home(request):
    if request.user.id == None:
        return redirect('/login/')

    clean_session(request)
    
    user = User.objects.get(id=request.user.id)
    icon = "img/" + str(user.id) + ".jpg"
    course = Course.objects.filter(member=request.user.id).order_by('id')
    for item in course:
        item.participation = Course.objects.get(id=item.id).member.count()
        item.save()

    p = Paginator(course, 5)
    if p.num_pages <= 1:
        course_list = course
        data = ''
    else:
        page = int(request.GET.get('page', 1))
        course_list = p.page(page)
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

    return render(request, 'mainpage_student.html', locals())

def teacher_home(request):
    if request.user.id == None:
        return redirect('/login/')

    clean_session(request)

    user = User.objects.get(id=request.user.id)
    course = Course.objects.filter(member=request.user.id).order_by('id')
    for item in course:
        item.participation = Course.objects.get(id=item.id).member.count()
        item.save()

    p = Paginator(course, 5)
    if p.num_pages <= 1:
        course_list = course
        data = ''
    else:
        page = int(request.GET.get('page', 1))
        course_list = p.page(page)
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
    return render(request, 'mainpage_teacher.html', locals())

def change_password(request):
    clean_session(request)
    user = User.objects.get(id=request.user.id)
    msg = 'no_msg'
    if request.method == 'POST':
        pwd_form = ChangePasswordForm(request.POST)
        if pwd_form.is_valid():
            org_pwd = pwd_form.cleaned_data['origin_pwd'] #new_pwd confirm_pwd
            if user.check_password(org_pwd):
                new_pwd = pwd_form.cleaned_data['new_pwd']
                confirm_pwd = pwd_form.cleaned_data['confirm_pwd']
                if new_pwd == confirm_pwd:
                    user.set_password(new_pwd)
                    user.save()
                    msg = 'success!'
                else:
                    msg = 'Two different new password!'
            else:
                msg = 'Wrong original password!'
    pwd_form = ChangePasswordForm()
    return render(request, 'change_password.html', locals())

