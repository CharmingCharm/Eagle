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
    msg = "no_msg"

    if request.session.get("teammate_management_msg") is not None:
        msg = request.session.get("teammate_management_msg")

    try:
        own_team = Team.objects.get(course=course, member=user)
    except:
        own_team = 0
    invite = list(Invitation.objects.filter(course=course, to_user=request.user.id, isAccept=0))
    invitation_list = []

    for invitation in invite:
        invite_user = User.objects.get(id=invitation.from_user)
        invitation_list.append({"id": invitation.id, 'truename': invite_user.truename, "description": invitation.description})

    return render(request, 'teammate_management.html', locals())


def random_form(group_size, num_group_in_size, total_group_size, course):
    student_list = []
    rand_student_list = []
    students = course.member.filter(field='student')# course
    for item in students:
        student_list.append(item.id)
    randlist = random.sample(range(0, total_group_size), total_group_size)# stuNum
    for index in range(0, total_group_size):
        rand_student_list.append(student_list[randlist[index]])

    count_stu = 0
    for index in range(0, len(num_group_in_size)):
        if index == 0:
            front = 0
        else:
            front = num_group_in_size[index - 1]
        back = front + num_group_in_size[index]

        for cycle in range(front, back):# num_group_in_size
            new_team = Team.objects.create(name='group ' + str(cycle), course=course)
            for cycle2 in range(0, group_size[index]):
                new_member = User.objects.get(id=rand_student_list[count_stu])
                new_team.member.add(new_member)
                count_stu = count_stu + 1
            new_team.save()
    return "Success!"

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

            if request.POST.get("group") is not None:
                size_type = int(request.POST.get("group"))
            else:
                size_type = None

            if consider_GPA and form_method == 2:
                form_method = 4
            if consider_GPA and form_method == 3:
                form_method = 5

                # messages.add_message(request, messages.success, 'You have successfully set the team forming!')

            if size_type is None:
                course.form_method = form_method
                course.team_number_1 = team_num
                course.team_number_2 = 0
                course.team_size_1 = group_size
                course.team_size_2 = 0
                course.save()
            else:
                resid = stuNum % group_size
                num_group1 = int(stuNum / group_size)
                num_group2 = num_group1 + 1
                if size_type == 1:
                    more1_num = resid % num_group1
                    normal_num = num_group1 - more1_num
                    average_more = int(resid / num_group1)
                    group1_normal = group_size + average_more
                    group1_abnormal = group1_normal + 1
                    
                    course.form_method = form_method
                    course.team_number_1 = more1_num
                    course.team_number_2 = normal_num
                    course.team_size_1 = group1_abnormal
                    course.team_size_2 = group1_normal
                    course.save()
                elif size_type == 2:
                    group2_abnormal = resid

                    course.form_method = form_method
                    course.team_number_1 = num_group2 - 1
                    course.team_number_2 = 1
                    course.team_size_1 = group_size
                    course.team_size_2 = group2_abnormal
                    course.save()
                
            if form_method == 1 or form_method == 3 or form_method == 5:
                # messages.add_message(request, messages.success, 'You have successfully set the team forming, wait for entering!')
                return redirect('/course/' + str(course_id))
            
            if form_method == 2:
                if size_type is None:
                    random_form([group_size],[team_num],stuNum,course)
                    return redirect('/course/' + str(course_id) + '/forming_method')
                else:
                    resid = stuNum % group_size
                    num_group1 = int(stuNum / group_size)
                    num_group2 = num_group1 + 1
                    if size_type == 1:
                        more1_num = resid % num_group1
                        normal_num = num_group1 - more1_num
                        average_more = int(resid / num_group1)
                        group1_normal = group_size + average_more
                        group1_abnormal = group1_normal + 1
                        random_form([group1_normal, group1_abnormal],[normal_num,more1_num],stuNum,course)
                    elif size_type == 2:
                        group2_abnormal = resid
                        random_form([group_size, group2_abnormal],[num_group2 - 1,1],stuNum,course)

                    return redirect('/course/' + str(course_id) + '/forming_method')

        return render(request, 'group_size.html', locals())
    return redirect('/')


def invite(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.filter(course_id=course.id)
    student_in_group_id = []
    student_in_group_id.append(request.user.id)

    if request.method == 'POST':
        to_user = int(request.POST.get("to_user"))
        description = request.POST.get("description")
        new_invite = Invitation.objects.create(from_user=request.user.id, to_user=to_user, description=description, course=course)
        new_invite.save()

    for item in team.values("member"):
        student_in_group_id.append(item.get('member'))

    student_free = User.objects.filter(course=course).exclude(id__in=student_in_group_id).exclude(field="teacher")

    return render(request, 'invite.html', locals())


def processInvite(request, course_id, invite_id, isAccept):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    process_invite = Invitation.objects.get(id=invite_id)
    num_of_groups = Team.objects.filter(course=course).count()
    msg = "no_msg"

    invite_from_user = User.objects.get(id=process_invite.from_user)
    if len(Team.objects.filter(course=course, member=invite_from_user)) == 0:
        team_from_user = None
    else:
        team_from_user = Team.objects.filter(course=course, member=invite_from_user).first()

    print(team_from_user)

    if isAccept == 1:

        
        if team_from_user is None:
            if num_of_groups < (course.team_number_1 + course.team_number_2):
                team_from_user = Team.objects.create(course=course, name="group " + str(num_of_groups), size=2)
                team_from_user.member.add(invite_from_user)
                team_from_user.member.add(user)
                team_from_user.save()
            else:
                process_invite.isAccept = 2
                process_invite.save()
                request.session['teammate_management_msg'] = "The number of groups are full! Please ask someone in group to invite you!"
                return redirect('/course/' + str(course.id) + '/teammate_management')
        else:
            if team_from_user.size < course.team_size_1:
                groups = Team.objects.filter(course=course)
                num_of_max_size = 0
                max_size_group_flag_is_full = 0
                for group in groups:
                    if group.size >= course.team_size_1:
                        num_of_max_size = num_of_max_size + 1
                    if num_of_max_size >= course.team_number_1:
                        max_size_group_flag_is_full = 1
                        break
                
                if (max_size_group_flag_is_full == 1 and team_from_user.size >= course.team_size_2):
                    process_invite.isAccept = 2
                    process_invite.save()
                    request.session['teammate_management_msg'] = "The group is full now! Please change a group!"
                    return redirect('/course/' + str(course.id) + '/teammate_management')

                team_from_user.member.add(user)
                team_from_user.size = team_from_user.size + 1
                team_from_user.save()
        
                process_invite.isAccept = 1
                process_invite.save()

                reject_invitation = Invitation.objects.filter(course=course, to_user=user.id).exclude(id=process_invite.id)

                for invtation in reject_invitation:
                    invtation.isAccept = 2
                    invtation.save()
                request.session['teammate_management_msg'] = "You are added into the group successfully!"
            
            else:
                process_invite.isAccept = 2
                process_invite.save()
                request.session['teammate_management_msg'] = "The group is full now! Please change a group!"

    elif isAccept == 2:
        process_invite.isAccept = 2
        process_invite.save()
        request.session['teammate_management_msg'] = "Reject successfully!"
    else:
        pass

    return redirect('/course/' + str(course.id) + '/teammate_management')


def forming_method(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.filter(course=course)
    return render(request, 'forming_method_1.html', locals())