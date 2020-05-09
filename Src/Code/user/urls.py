"""UIC_3DLab URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from user import views

app_name = 'user'
urlpatterns = [
    path('', views.index),
    path('admin/', admin.site.urls),
    path('login/', views.login_self),
    path('register/', views.register),
    path('logout/', views.logout_self),
    path('student_home/', views.student_home),
    path('teacher_home/', views.teacher_home),
    path('change_password/', views.change_password),
    path('change_password/', views.change_password),
]
