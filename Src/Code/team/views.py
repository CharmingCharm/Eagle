from django.shortcuts import render,redirect
from course.models import Course
from .models import Team
from django.contrib import messages
from user.models import User
from .models import Vote


def max_list(lt):
    temp = 0
    max_ele = 0
    for i in lt:
        if lt.count(i) > temp:
            max_ele = i
            temp = lt.count(i)
    return max_ele


def vote_leader(request, course_id):
    if request.user.is_authenticated:
        course = Course.objects.get(id=course_id)
        team = Team.objects.filter(member=request.user.id, course=course_id).first()
        if team:
            if team.leader == 0:

                members = User.objects.filter(team=team.id)
                if request.method == "POST":
                    vote_result = request.POST.get("group")
                    vote = Vote.objects.create(team=team.id, member=request.user.id, vote_id=vote_result)
                    vote.save()
                    messages.add_message(request, messages.SUCCESS, 'Your vote was submitted success!')
                    msg = 'Your vote was submitted success!'

                    vote_final = Vote.objects.filter(team=team.id)

                    if len(vote_final) >= len(members):
                        getmax = []
                        for item in vote_final:
                            getmax.append(item.vote_id)
                        leader_id = max_list(getmax)
                        team.leader = leader_id
                        team.save()

                    return redirect('/course/' + str(course_id))
                return render(request, 'vote_leader.html', locals())
            messages.add_message(request, messages.ERROR, 'Your team has already have a leader!')
            return redirect('/course/' + str(course_id))
        messages.add_message(request, messages.ERROR, 'You are not in a team yet!')
        return redirect('/course/'+str(course_id))
    return render(request, 'login.html', locals())