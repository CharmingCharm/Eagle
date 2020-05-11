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
from django.urls import path
from submission import views

app_name = 'submission'
urlpatterns = [
    path('course/<int:course_id>/modify_submission', views.modify_submission),
    path('course/<int:course_id>/add_submission', views.add_submission),
    path('course/<int:course_id>/team/<int:team_id>/leader_assessment', views.leader_assessment),
    path('course/<int:course_id>/team/<int:team_id>/leader_assessment/<int:submissionitem_id>', views.submission_assessment),
    path('course/<int:course_id>/team/<int:team_id>/member_assessment', views.member_assessment),
]
