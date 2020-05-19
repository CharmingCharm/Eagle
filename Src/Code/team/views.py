from django.shortcuts import render,redirect
from course.models import Course
from .models import Team
from django.contrib import messages
from user.models import User, Student
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
        vote_msg = 'no_msg'
        course = Course.objects.get(id=course_id)
        team = Team.objects.filter(member=request.user.id, course=course_id).first()
        if team:
            if team.leader == 0:

                members = User.objects.filter(team=team.id)
                if request.method == "POST":
                    vote_result = request.POST.get("group")
                    vote_dup = Vote.objects.filter(team=team.id, member=request.user.id).first()
                    if vote_dup:
                        vote_msg = 'You have already vote for your leader!'
                        return render(request, 'vote_leader.html', locals())
                    vote = Vote.objects.create(team=team.id, member=request.user.id, vote_id=vote_result)
                    vote.save()
                    request.session['course_msg'] = 'Your vote was submitted success!'
                    vote_final = Vote.objects.filter(team=team.id)

                    if len(vote_final) >= len(members):
                        getmax = []
                        for item in vote_final:
                            getmax.append(item.vote_id)
                        leader_id = max_list(getmax)
                        team.leader = leader_id
                        team.save()
                        leader = User.objects.get(id=leader_id)
                        request.session['course_msg'] = leader.truename + ' becomes your leader!'
                    return redirect('/course/' + str(course_id))
                return render(request, 'vote_leader.html', locals())
            request.session['course_msg'] = 'Your team has already have a leader!'
            return redirect('/course/' + str(course_id))
        request.session['course_msg'] = 'You are not in a team yet!'
        return redirect('/course/'+str(course_id))
    return render(request, 'login.html', locals())

def check_full(team, course):
    check = 0
    if team is None:
        if num_of_groups >= (course.team_number_1 + course.team_number_2):
            check = 1
    else:
        if team.size < course.team_size_1:
            groups = Team.objects.filter(course=course)
            num_of_max_size = 0
            max_size_group_flag_is_full = 0
            for group in groups:
                if group.size >= course.team_size_1:
                    num_of_max_size = num_of_max_size + 1
                if num_of_max_size >= course.team_number_1:
                    max_size_group_flag_is_full = 1
                    break
            if (max_size_group_flag_is_full == 1 and team.size >= course.team_size_2):
                check = 1
        else:
            check = 1
    return check

def manage(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    msg = "no_msg"
    isFull = 0

    if request.session.get("teammate_management_msg") is not None:
        msg = request.session.get("teammate_management_msg")

    try:
        own_team = Team.objects.get(course=course, member=user)
        if check_full(own_team, course):
            isFull = 1
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
    
    #########################################################
    if course.form_method == 4:
        students = User.objects.filter(course=course)
        teams = Team.objects.filter(course=course)
        # 全班平均GPA
        entire_GPA = 0
        for item in teams:
            for team_member in item.member.all():
                entire_GPA += team_member.student.GPA
        course_avg_GPA = entire_GPA/students.count()
        print("course average GPA: " + str(course_avg_GPA))
        # 每一个组的平均GPA计算
        teams = Team.objects.filter(course=course)
        team_to_be_changed = teams
        upper_bound = 3.6
        lower_bound = 2.8
        for origin_team in teams:
            total_gpa = 0.0
            for team_member in origin_team.member.all():
                total_gpa += team_member.student.GPA
            avg_gpa = total_gpa / origin_team.member.count()
            origin_team.avg_GPA = avg_gpa
            print("origin:"+str(avg_gpa))
            origin_team.save()

        for origin_team in teams:
            if origin_team.avg_GPA <= upper_bound and origin_team.avg_GPA >= lower_bound:
                origin_team.isInGPA = True
                origin_team.save()
            else:
                origin_team.isInGPA = False
                origin_team.save()
        # 不在范围里最小的组
        notInGPA_team = teams.filter(isInGPA=False).order_by("avg_GPA")
        min_notInGPA_team = notInGPA_team.first()
        if min_notInGPA_team:
            print("min out of bound" + str(min_notInGPA_team.avg_GPA))
        else:
            print("no Min team out of bound!")
        # 不在范围里最大的组
        max_notInGPA_team = notInGPA_team.last()

        if max_notInGPA_team:
            print("max out of bound" + str(max_notInGPA_team.avg_GPA))
        else:
            print("no MAX team out of bound!")

        choice = random.randint(1, 2)
        if max_notInGPA_team or min_notInGPA_team:
            if choice == 1:
                if min_notInGPA_team.avg_GPA >= upper_bound:
                    max_notInGPA_team = min_notInGPA_team
                if max_notInGPA_team.avg_GPA >= upper_bound:
                    # 不在范围里最大的组的最大的GPA的人
                    max_person_notIn = Student.objects.filter(user__team=max_notInGPA_team).order_by("-GPA").first()
                    # 整个班级组里倒数第二小的GPA的人
                    min_person_total = Student.objects.filter(user__course=course).order_by("GPA")[1]
                    # 映射到组
                    team1 = Team.objects.filter(course=course, member=max_person_notIn.user).first()
                    team2 = Team.objects.filter(course=course, member=min_person_total.user).first()

                    # 置换组员
                    team1.member.add(min_person_total.user)
                    team1.member.remove(max_person_notIn.user)
                    team2.member.add(max_person_notIn.user)
                    team2.member.remove(min_person_total.user)

                    team1.save()
                    team2.save()

            if choice == 2:
                if max_notInGPA_team.avg_GPA <= lower_bound:
                    min_notInGPA_team = max_notInGPA_team
                if min_notInGPA_team.avg_GPA <= lower_bound:
                    # 不在范围里最小的组的最小的GPA的人
                    min_person_notIn = Student.objects.filter(user__team=min_notInGPA_team).order_by("GPA").first()
                    print(min_person_notIn.user)
                    # 整个班级组里第二大的GPA的人
                    max_person_total = Student.objects.filter(user__course=course).order_by("-GPA")[1]
                    print(max_person_total.user.student.GPA)
                    # 映射到组
                    team1 = Team.objects.filter(course=course, member=min_person_notIn.user).first()
                    team2 = Team.objects.filter(course=course, member=max_person_total.user).first()
                    # 置换组员
                    team1.member.add(max_person_total.user)
                    team1.member.remove(min_person_notIn.user)
                    team2.member.add(min_person_notIn.user)
                    team2.member.remove(max_person_total.user)

                    team1.save()
                    team2.save()
        #更新并保存数据库
        for origin_team in teams:
            total_gpa = 0.0
            for team_member in origin_team.member.all():
                total_gpa += team_member.student.GPA
            avg_gpa = total_gpa / origin_team.member.count()
            origin_team.avg_GPA = avg_gpa
            print("after:" + str(avg_gpa))
            origin_team.save()

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

            if form_method == 1 or form_method == 2 or form_method == 4:
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
            else:
                if stuNum % 2 == 0:
                    course.team_number_1 = stuNum / 2
                    course.team_number_2 = 0
                    course.team_size_1 = 2
                    course.team_size_2 = 0
                else:
                    course.team_number_1 = (stuNum - 1) / 2
                    course.team_number_2 = 1
                    course.team_size_1 = 2
                    course.team_size_2 = 1
                course.form_method = form_method
                course.save()
                
            if form_method == 1 or form_method == 3 or form_method == 5:
                request.session['course_msg'] = 'You have successfully set the team forming, wait for entering!'
                return redirect('/course/' + str(course_id))
            
            if form_method == 2 or form_method == 4:
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
                    else:
                        pass
                    # if form_method == 4:
                    #     ##################################
                        
                    #     ##################################
                    #     # team = Team.objects.filter(course=course)
                    #     # team_to_be_changed = team
                    #     # upper_bound = 3.2
                    #     # lower_bound = 2.7
                    #     # for origin_team in team_to_be_changed:
                    #     #     total_gpa = 0
                    #     #     for team_member in origin_team.member:
                    #     #         total_gpa += team_member.student.GPA
                    #     #     avg_gpa = total_gpa/origin_team.member.count()
                    #     #     print(avg_gpa)
                    #     return redirect('/course/' + str(course_id) + '/forming_method')


                    isSetGroup = 'yes'
                    request.session['isSetGroup'] = isSetGroup
                    request.session['form_method_msg'] = 'Random group students succeed!'
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

def check_finish(course):
    current_team_num = Team.objects.filter(course=course).count()
    
    if course.team_number_2 == 1:
        if course.team_number_1 == current_team_num:

            all_teams_in_course = Team.objects.filter(course=course)
            student_in_group_id = []
            for team in all_teams_in_course.values("member"):
                student_in_group_id.append(team.get('member'))
            
            last_student = User.objects.filter(course=course).exclude(id__in=student_in_group_id).exclude(field="teacher").first()
            solo_small_team = Team.objects.create(course=course, name="small_group " + str(current_team_num), size=1)
            solo_small_team.member.add(last_student)
            solo_small_team.save()

def processInvite(request, course_id, invite_id, isAccept):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    process_invite = Invitation.objects.get(id=invite_id)
    num_of_groups = Team.objects.filter(course=course).count()
    msg = "no_msg"
    group_title = "group "
    
    if course.form_method == 3 or course.form_method == 5:
        group_title = "small_group "

    invite_from_user = User.objects.get(id=process_invite.from_user)
    if len(Team.objects.filter(course=course, member=invite_from_user)) == 0:
        team_from_user = None
    else:
        team_from_user = Team.objects.filter(course=course, member=invite_from_user).first()

    print(team_from_user)

    if isAccept == 1:

        if team_from_user is None:
            if num_of_groups < (course.team_number_1 + course.team_number_2):
                team_from_user = Team.objects.create(course=course, name=group_title + str(num_of_groups), size=2)
                team_from_user.member.add(invite_from_user)
                team_from_user.member.add(user)
                team_from_user.save()
                process_invite.isAccept = 1
                process_invite.save()
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

        if course.form_method == 3 or course.form_method == 5:
            check_finish(course)

    elif isAccept == 2:
        process_invite.isAccept = 2
        process_invite.save()
        request.session['teammate_management_msg'] = "Reject successfully!"
    else:
        pass

    return redirect('/course/' + str(course.id) + '/teammate_management')


def random_form_groups(course, group_list):
    # pass
    rand_group_list = []
    randlist = random.sample(range(0, len(group_list)), len(group_list))
    for index in range(0, len(group_list)):
        rand_group_list.append(group_list[randlist[index]])

    count_group = 0
    combination_groups = []
    while len(rand_group_list) > 0:
        combination_groups.append(rand_group_list.pop())

        if len(combination_groups) == 1 and len(rand_group_list) == 0:
            formal_team = Team.objects.create(course=course, name="group " + str(count_group))
            count_group = count_group + 1
            small_team = Team.objects.get(id=combination_groups[0])
            for member in small_team.member.all():
                formal_team.member.add(member)
            formal_team.size = small_team.size
            formal_team.save()
            small_team.member.clear()
            Team.objects.filter(id=small_team.id).delete()
            break

        if len(combination_groups) == 1:
            continue
        
        if len(combination_groups) == 2:
            formal_team = Team.objects.create(course=course, name="group " + str(count_group))
            count_group = count_group + 1
            small_teams = Team.objects.filter(id__in=combination_groups)
            for team in small_teams:
                for member in team.member.all():
                    formal_team.member.add(member)
                team.member.clear()
            small_teams.delete()
            formal_team.save()
            combination_groups = []
    return count_group

def forming_method(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    teams = Team.objects.filter(course=course)
    form_method_msg = 'no_msg'
    if request.session.get('form_method_msg') is not None:
        form_method_msg = request.session.get('form_method_msg')
        request.session.pop('form_method_msg')

#     #########################################################################################################
#     students = User.objects.filter(course=course)
#     # 全班平均GPA
#     entire_GPA = 0
#     for item in teams:
#         for team_member in item.member.all():
#             entire_GPA += team_member.student.GPA
#     course_avg_GPA = entire_GPA/students.count()
#     print("course average GPA: " + str(course_avg_GPA))
#     # 每一个组的平均GPA计算
#     teams = Team.objects.filter(course=course)
#     team_to_be_changed = teams
#     upper_bound = 3.6
#     lower_bound = 2.8
#     for origin_team in teams:
#         total_gpa = 0.0
#         for team_member in origin_team.member.all():
#             total_gpa += team_member.student.GPA
#         avg_gpa = total_gpa / origin_team.member.count()
#         origin_team.avg_GPA = avg_gpa
#         print("origin:"+str(avg_gpa))
#         origin_team.save()

#     for origin_team in teams:
#         if origin_team.avg_GPA <= upper_bound and origin_team.avg_GPA >= lower_bound:
#             origin_team.isInGPA = True
#             origin_team.save()
#         else:
#             origin_team.isInGPA = False
#             origin_team.save()
#     # 不在范围里最小的组
#     notInGPA_team = teams.filter(isInGPA=False).order_by("avg_GPA")
#     min_notInGPA_team = notInGPA_team.first()
#     if min_notInGPA_team:
#         print("min out of bound" + str(min_notInGPA_team.avg_GPA))
#     else:
#         print("no Min team out of bound!")
#     # 不在范围里最大的组
#     max_notInGPA_team = notInGPA_team.last()

#     if max_notInGPA_team:
#         print("max out of bound" + str(max_notInGPA_team.avg_GPA))
#     else:
#         print("no MAX team out of bound!")

#     choice = random.randint(1, 2)
#     if max_notInGPA_team or min_notInGPA_team:
#         if choice == 1:
#             if min_notInGPA_team.avg_GPA >= upper_bound:
#                 max_notInGPA_team = min_notInGPA_team
#             if max_notInGPA_team.avg_GPA >= upper_bound:
#                 # 不在范围里最大的组的最大的GPA的人
#                 max_person_notIn = Student.objects.filter(user__team=max_notInGPA_team).order_by("-GPA").first()
#                 # 整个班级组里倒数第二小的GPA的人
#                 min_person_total = Student.objects.filter(user__course=course).order_by("GPA")[1]
#                 # 映射到组
#                 team1 = Team.objects.filter(course=course, member=max_person_notIn.user).first()
#                 team2 = Team.objects.filter(course=course, member=min_person_total.user).first()

#                 # 置换组员
#                 team1.member.add(min_person_total.user)
#                 team1.member.remove(max_person_notIn.user)
#                 team2.member.add(max_person_notIn.user)
#                 team2.member.remove(min_person_total.user)

#                 team1.save()
#                 team2.save()

#         if choice == 2:
#             if max_notInGPA_team.avg_GPA <= lower_bound:
#                 min_notInGPA_team = max_notInGPA_team
#             if min_notInGPA_team.avg_GPA <= lower_bound:
#                 # 不在范围里最小的组的最小的GPA的人
#                 min_person_notIn = Student.objects.filter(user__team=min_notInGPA_team).order_by("GPA").first()
#                 print(min_person_notIn.user)
#                 # 整个班级组里第二大的GPA的人
#                 max_person_total = Student.objects.filter(user__course=course).order_by("-GPA")[1]
#                 print(max_person_total.user.student.GPA)
#                 # 映射到组
#                 team1 = Team.objects.filter(course=course, member=min_person_notIn.user).first()
#                 team2 = Team.objects.filter(course=course, member=max_person_total.user).first()
#                 # 置换组员
#                 team1.member.add(max_person_total.user)
#                 team1.member.remove(min_person_notIn.user)
#                 team2.member.add(min_person_notIn.user)
#                 team2.member.remove(max_person_total.user)

#                 team1.save()
#                 team2.save()
#     #更新并保存数据库
#     for origin_team in teams:
#         total_gpa = 0.0
#         for team_member in origin_team.member.all():
#             total_gpa += team_member.student.GPA
#         avg_gpa = total_gpa / origin_team.member.count()
#         origin_team.avg_GPA = avg_gpa
#         print("after:" + str(avg_gpa))
#         origin_team.save()
# ####################################################################################################################


    if request.method == 'POST':
        if course.form_method == 3 or course.form_method == 5:
            if (course.team_number_1 + course.team_number_2) % 2:
                if course.team_number_2 == 1:
                    group_list = []
                    for team in teams:
                        group_list.append(team.id)

                    solo_small_team_id = group_list.pop()

                    normal_group_list_size = len(group_list)
                    form_with_solo = group_list.pop(random.randint(0, normal_group_list_size - 1))
                    
                    group_num = random_form_groups(course, group_list)

                    formal_team = Team.objects.create(course=course, name="group " + str(group_num))
                    group_num = group_num + 1
                    small_teams = Team.objects.filter(id__in=[solo_small_team_id, form_with_solo])
                    for team in small_teams:
                        for member in team.member.all():
                            formal_team.member.add(member)
                        team.member.clear()
                    small_teams.delete()
                    formal_team.save()
                    course.team_size_1 = 4
                    course.team_size_2 = 0
                    course.team_number_1 = group_num
                    course.team_number_2 = 0
                    course.save()
                    return redirect("/course/" + str(course.id) + "/forming_method")
                else:
                    group_list = []
                    for team in teams:
                        group_list.append(team.id)
                    group_num = random_form_groups(course, group_list)
                    course.team_size_1 = 4
                    course.team_size_2 = 0
                    course.team_number_1 = group_num
                    course.team_number_2 = 0
                    course.save()
                    return redirect("/course/" + str(course.id) + "/forming_method")
            else:
                group_list = []
                for team in teams:
                    group_list.append(team.id)
                group_num = random_form_groups(course, group_list)
                course.team_size_1 = 4
                course.team_size_2 = 0
                course.team_number_1 = group_num
                course.team_number_2 = 0
                course.save()
                return redirect("/course/" + str(course.id) + "/forming_method")
    return render(request, 'forming_method_1.html', locals())