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
from course import views

app_name = 'course'
urlpatterns = [
    path('course/<int:course_id>', views.course_page),
    path('course/<int:course_id>/generate_student', views.generate_student),
    path('course/<int:course_id>/export_contribution', views.export_contribution),
    path('course/<int:course_id>/import_student_excel', views.import_student_excel),
    path('course/<int:course_id>/import_student_individual', views.import_student_individual),
]
