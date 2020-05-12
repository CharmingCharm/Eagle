from django.shortcuts import render,redirect
from course.models import Course
from .models import Team
from django.contrib import messages
from user.models import User
from .models import Vote, Team, Invitation
import random

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


def manage(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    try:
        own_team = Team.objects.get(course=course, member=user)
    except:
        own_team = 0
    
    invite = Invitation.objects.filter(course=course, to_user=request.user.id, isAccept=0)
    return render(request, 'teammate_management.html', locals())


def group_size(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    stuNum = course.member.filter(field='student').count()
    if request.user.is_authenticated and user.field == 'teacher':
        if request.method == 'POST':
            group_size = int(request.POST.get("group_size"))
            form_method = int(request.POST.get("form_method"))
            consider_GPA = request.POST.get("consider_GPA")
            team_num = int(stuNum/group_size)

            if consider_GPA and form_method == 2:
                form_method = 4
            if consider_GPA and form_method == 3:
                form_method = 5

            if stuNum % group_size == 0:
                course.team_num = team_num
                course.form_method = form_method
                course.save()
                # messages.add_message(request, messages.success, 'You have successfully set the team forming!')

            if form_method == 1 or form_method == 3 or form_method == 5:
                messages.add_message(request, messages.success, 'You have successfully set the team forming, wait for entering!')
                return redirect('/course/' + str(course_id))

            if form_method == 2:
                student_list = []
                rand_student_list = []
                students = course.member.filter(field='student')
                for item in students:
                    student_list.append(item.id)
                randlist = random.sample(range(0, stuNum), stuNum)
                for index in range(0, stuNum):
                    rand_student_list.append(student_list[randlist[index]])

                index = 0
                for cycle in range(0, team_num):
                    new_team = Team.objects.create(name='group'+str(cycle), course=course)
                    for cycle2 in range(0, group_size):
                        new_member = User.objects.get(id=rand_student_list[cycle * group_size + cycle2])
                        new_team.member.add(new_member)
                    new_team.save()
                return redirect('/course/' + str(course_id) + '/forming_method')
        return render(request, 'group_size.html', locals())
    return redirect('/')


def invite(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.filter(course_id=course.id)
    student_free_id = []

    if request.method == 'POST':
        to_user = int(request.POST.get("to_user"))
        description = request.POST.get("description")
        new_invite = Invitation.objects.create(from_user=request.user.id, to_user=to_user, description=description, course=course)
        new_invite.save()

    for item in team.values("member"):
        student_free_id.append(item.get('member'))

    student_free = User.objects.filter(course=course).exclude(id__in=student_free_id)

    return render(request, 'invite.html', locals())


def processInvite(request, course_id, invite_id, isAccept):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    process_invite = Invitation.objects.get(id=invite_id)
    if isAccept == 1:
        process_invite.isAccept = 1
        process_invite.save()
        own_team = Team.objects.filter(course=course, member=user).first()
        new_member = User.objects.get(id=process_invite.from_user)
        if own_team and own_team.member.count() < course.team_num:
            own_team.member.add(new_member)
            print('hhhhhhhhhhhhhhhhhhhhhhhhh')
            # msg
            redirect('course/'+str(course.id)+'/teammate_management')
        if not own_team:
            create_team = Team.objects.create(course=course)
            create_team.member.add(user)
            create_team.member.add(new_member)
            print('gggggggggggggggggggggggggggg')
            # msg
            redirect('course/' + str(course.id) + '/teammate_management')
        else:
            print("emmmmmmmmmmmmmmmmm")
            redirect('course/' + str(course.id) + '/teammate_management')
    elif isAccept == 2:
        process_invite.isAccept = 2
        process_invite.save()
        print('qqqqqqqqqqqqqqqqqqq')
        redirect('course/' + str(course.id) + '/teammate_management')
    redirect('course/' + str(course.id) + '/teammate_management')


def forming_method(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.filter(course=course)
    return render(request, 'forming_method_1.html', locals())