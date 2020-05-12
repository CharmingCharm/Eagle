from django.shortcuts import render, redirect, HttpResponse
from .forms import SubmissionItemForm
from course.models import Course
from submission.models import SubmissionItem
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
    if request.user.is_authenticated:
        if request.method == 'POST':
            add_submission_form = SubmissionItemForm(request.POST)
            if add_submission_form.is_valid():
                title = add_submission_form.cleaned_data['title']
                percentage = add_submission_form.cleaned_data['percentage']
                submission_dup = SubmissionItem.objects.filter(title=title).first()
                if not submission_dup:
                    request.session["addSubmission"] = {"title": title, "percentage": percentage}
                    return redirect('/course/' + str(course_id) + "/modify_submission")
                return redirect('/course/' + str(course_id) + '/add_submission')
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

        if request.method == 'POST':
            if request.POST.get("confirm") is not None:
                modifyId = list(map(int, request.POST.getlist("modifyId")))
                titles = request.POST.getlist("title")
                percentages = list(map(float, request.POST.getlist("percentage")))

                if sum(percentages) == 100:
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
                deleteId.add(int(request.POST.get("deleteItemId")[0]))
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
    if team.leader != request.user.id:
        if request.method == 'POST':
            leader_mark = request.POST.get("leader_mark")
            leader_assessment = LeaderAssessment.objects.create(leader=team.leader, member=request.user.id, mark=leader_mark)
            leader_assessment.save()
            print("mark success!")
            redirect('/course/' + str(course_id))
        print("Your are a leader!")
        redirect('/course/' + str(course_id))
    return render(request, 'member_assessment.html', locals())


def leader_assessment(request, course_id, team_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.get(id=team_id)
    submission = SubmissionItem.objects.filter(course=course)

    return render(request, 'leader_assessment.html', locals())


def submission_assessment(request, course_id, team_id, submissionitem_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    team = Team.objects.get(id=team_id)
    submission = SubmissionItem.objects.get(id=submissionitem_id)
    return render(request, 'submission_assessment.html', locals())

