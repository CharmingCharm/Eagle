from django.shortcuts import render, redirect, HttpResponse
from .forms import SubmissionItemForm
from course.models import Course
from submission.models import SubmissionItem, SubmissionContribution
from team.models import Team
from user.models import User
from .models import LeaderAssessment
from django.contrib.auth import authenticate, logout, login
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator
import json

def clean_session(request):
    if request.session.get("deleteId") is not None:
        request.session.pop("deleteId")
    if request.session.get("addSubmission") is not None:
        request.session.pop("addSubmission")
    if request.session.get("newSubmission") is not None:
        request.session.pop("newSubmission")
    if request.session.get('user_list') is not None:
        request.session.pop('user_list')


def add_submission(request, course_id):
    course = Course.objects.get(id=course_id)
    msg = "no_msg"
    if request.user.is_authenticated:
        if request.method == 'POST':
            add_submission_form = SubmissionItemForm(request.POST)
            if add_submission_form.is_valid():
                title = add_submission_form.cleaned_data['title']
                percentage = add_submission_form.cleaned_data['percentage']
                submission_dup = SubmissionItem.objects.filter(course=course, title=title).first()
                if submission_dup:
                    msg = "Duplicate submission name!"
                    return render(request, 'add_submission_item.html', locals())
                
                if float(percentage) < 0:
                    msg = "The percentage cannot less than 0%!"
                    return render(request, 'add_submission_item.html', locals())

                if float(percentage) > 100:
                    msg = "The percentage cannot greater than 100%!"
                    return render(request, 'add_submission_item.html', locals())
                
                request.session["addSubmission"] = {"title": title, "percentage": percentage}
                return redirect('/course/' + str(course_id) + "/modify_submission")

        add_submission_form = SubmissionItemForm()
        return render(request, 'add_submission_item.html', locals())
    return redirect('/')


@csrf_exempt
def modify_submission(request, course_id):
    if request.user.is_authenticated:
        user = request.user
        course = Course.objects.get(id=course_id)
        teachers = course.member.filter(field='teacher')
        memNum = course.member.count()
        teamNum = Team.objects.filter(course=course).count()

        msg = "no_msg"
        deleteId = set()

        if request.session.get("deleteId") is not None:
            deleteId = request.session.get("deleteId")

        if request.session.get("addSubmission") is not None:
            addSubmission = request.session.get("addSubmission")
            if request.session.get("newSubmission") is not None:
                newSubmission = request.session.get("newSubmission")
            else:
                newSubmission = list()
            addSubmission.update({"index": len(newSubmission)})
            newSubmission.append(addSubmission)
            request.session.pop("addSubmission")
            request.session["newSubmission"] = newSubmission
        elif request.session.get("newSubmission") is not None:
            newSubmission = request.session.get("newSubmission")
        else:
            newSubmission = list()
        
        if request.method == 'POST':
            if request.POST.get("confirm") is not None:
                for title_item in request.POST.getlist("title"):
                    if title_item == "":
                        msg = "Empty titles exist!"
                        submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                        return render(request, 'modify_submission.html', locals())

                for percentage_item in request.POST.getlist("percentage"):
                    if percentage_item == "":
                        msg = "Empty percentage exist!"
                        submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                        return render(request, 'modify_submission.html', locals())

                modifyId = list(map(int, request.POST.getlist("modifyId")))
                titles = request.POST.getlist("title")
                percentages = list(map(float, request.POST.getlist("percentage")))

                title_set = set(titles)
                if len(title_set) != len(titles):
                    msg = "Duplicate submission name!"
                    submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                    return render(request, 'modify_submission.html', locals())

                for percentage_of_submission in percentages:
                    if percentage_of_submission > 100 or percentage_of_submission < 0:
                        msg = "Some percentage is out of bound!"
                        submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                        return render(request, 'modify_submission.html', locals())

                if sum(percentages) == 100 or (len(titles) == 0 and len(percentages) == 0):
                    submissionItem = SubmissionItem.objects.filter(course=course_id)
                    submissionItem.filter(id__in=deleteId).delete()
                    for index in range(len(modifyId),len(titles)):
                        SubmissionItem.objects.create(title=titles[index], percentage=percentages[index], course_id=course_id)
                    for index in range(len(modifyId)):
                        submissionItem.filter(id=modifyId[index]).update(title=titles[index])
                        submissionItem.filter(id=modifyId[index]).update(percentage=percentages[index])
                    request.session['msg'] = "Success saving the modifying of submissions!"
                    clean_session(request)
                    return redirect("/course/" + str(course.id))
                else:
                    submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                    msg = "Your sum of percentage is not 100 percent!!"
                    return render(request, 'modify_submission.html', locals())
            elif request.POST.get("deleteNewIndex") is not None:
                for item in newSubmission:
                    if item.get("index") == int(request.POST.get("deleteNewIndex")[0]):
                        newSubmission.remove(item)
                        request.session["newSubmission"] = newSubmission
                        break
                submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
            else:

                deleteId.add(int(request.POST.get("deleteItemId")))
                request.session["deleteId"] = deleteId
                submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                msg = "Currently delete it!"
        else:
            submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
    return render(request, 'modify_submission.html', locals())


def member_assessment(request, course_id, team_id):
    course = Course.objects.get(id=course_id)
    team = Team.objects.get(id=team_id)
    leader = User.objects.get(id=team.leader)
    user = User.objects.get(id=request.user.id)
    member_assessment_msg = 'no_msg'
    if team.leader != request.user.id:
        if request.method == 'POST':
            leader_mark = request.POST.get("leader_mark")

            leader_assessment = LeaderAssessment.objects.get(leader=team.leader, member=request.user.id, team=team)
            leader_assessment.mark = leader_mark
            leader_assessment.save()
            request.session['course_msg'] = "Assess your leader success!"
            return redirect("/course/" + str(course.id))
        redirect('/course/' + str(course_id))
    return render(request, 'member_assessment.html', locals())


def leader_assessment(request, course_id, team_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.get(id=team_id)
    submission = SubmissionItem.objects.filter(course=course, is_finished=1)
    submission_contribution = SubmissionContribution.objects.filter(team=team)

    clean_session(request)
    leader_msg = 'no_msg'
    if request.session.get('leader_msg') is not None:
        leader_msg = request.session.get('leader_msg')
        request.session.pop('leader_msg')
    return render(request, 'leader_assessment.html', locals())


def submission_assessment(request, course_id, team_id, submissionitem_id):
    submission_assessment_msg = "no_msg"
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.get(id=team_id)
    submission = SubmissionItem.objects.get(id=submissionitem_id)
    leader = User.objects.get(id=team.leader)
    index = 0
    if request.method == 'POST':
        for item in range(1, team.member.count()+1):
            mark = request.POST.get("member_mark"+str(item))

            if mark is None:
                submission_assessment_msg = "Some members are not assessed!"
                return render(request, 'submission_assessment.html', locals())

            to_member_id = int(request.POST.get("member_id"+str(item)))
            to_member = User.objects.get(id=to_member_id)
            submission_assessment = SubmissionContribution.objects.get(member=to_member, submission=submission, team=team)
            submission_assessment.value = mark
            submission_assessment.save()
        request.session['leader_msg'] = "Assess " + submission.title + " success!"
        return redirect("/course/" + str(course.id) + "/team/" + str(team.id) + "/leader_assessment")
    return render(request, 'submission_assessment.html', locals())

