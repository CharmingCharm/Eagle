from .models import User
from django.contrib.auth import authenticate, logout, login
from django.shortcuts import render, redirect
from django.contrib import messages
from .forms import LoginForm, RegisterForm


def index(request):
    return render(request, 'index.html')

def login_self(request):
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
    messages.add_message(request, messages.SUCCESS, 'Logout successfully.')
    return redirect("/")

def student_home(request):
    user = User.objects.get(id=request.user.id)
    return render(request, 'mainpage_student.html', locals())

def teacher_home(request):
    user = User.objects.get(id=request.user.id)
    return render(request, 'mainpage_teacher.html', locals())

def change_password(request):
    return render(request, 'change_password.html', locals())