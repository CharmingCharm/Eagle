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

from team import views

app_name = 'team'
urlpatterns = [
    path('course/<int:course_id>/vote_leader', views.vote_leader),
    path('course/<int:course_id>/teammate_management', views.manage),
    path('course/<int:course_id>/invite', views.invite),
    path('course/<int:course_id>/group_size', views.group_size),
    path('course/<int:course_id>/forming_method', views.forming_method),
]
