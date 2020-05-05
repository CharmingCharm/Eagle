from django.shortcuts import render,redirect
from course.models import Course
from .models import Team
from django.contrib import messages


def vote_leader(request, course_id):
    if request.user.is_authenticated:
        course = Course.objects.get(id=course_id)
        team = Team.objects.filter(member=request.user.id, course=course_id)
        if team:
            return render(request, 'vote_leader.html', locals())
        messages.add_message(request, messages.ERROR, 'You are not in a team yet!')
        return redirect('/course/'+str(course_id))
    return render(request, 'login.html', locals())