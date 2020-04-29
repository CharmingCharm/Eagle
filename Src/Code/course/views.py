from django.shortcuts import render
from user.models import User
from .models import Course


def course_page(request, course_id):
    user = User.objects.get(id=request.user.id)
    course = Course.objects.get(id=course_id)
    teacher = User.objects.filter(field='teacher', course=course_id)
    return render(request, 'course.html', locals())
