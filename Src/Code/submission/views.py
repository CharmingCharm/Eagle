from django.shortcuts import render, redirect, HttpResponse
from .forms import SubmissionItemForm
from course.models import Course
from submission.models import SubmissionItem
from user.models import User
from django.contrib.auth import authenticate, logout, login
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator
import json

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
                    submission_new = SubmissionItem.objects.create(title=title,percentage=percentage,course_id=course_id)
                    submission_new.save()
                    messages.add_message(request, messages.SUCCESS, 'Add submission item succeed!')
                    return redirect('/course/'+str(course_id))
                messages.add_message(request, messages.ERROR, 'The title of the submission item exists!')
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
            request.session.get("deleteId")
            deleteId = request.session.get("deleteId")

        if request.method == 'POST':
            if request.POST.get("confirm") is not None:
                modifyId = list(map(int, request.POST.getlist("modifyId")))
                titles = request.POST.getlist("title")
                percentages = list(map(float, request.POST.getlist("percentage")))

                if sum(percentages) == 100:
                    submissionItem = SubmissionItem.objects.filter(course=course_id)
                    submissionItem.filter(id__in=deleteId).delete()
                    for index in range(len(modifyId)):
                        submissionItem.filter(id=modifyId[index]).update(title=titles[index])
                        submissionItem.filter(id=modifyId[index]).update(percentage=percentages[index])
                    request.session['msg'] = "Success saving the modifying of submissions!"
                    return redirect("/course/" + str(course.id))
                else:
                    submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                    msg = "Your sum of percentage is not 100 percent!!"
                    return render(request, 'modify_submission.html', locals())
            else:
                deleteId.add(int(request.POST.get("deleteItemId")[0]))
                request.session["deleteId"] = deleteId
                submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
                msg = "Currently delete it!"
        else:
            submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
    return render(request, 'modify_submission.html', locals())


def forming_method(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    return render(request, 'add_submission_item.html', locals())


def leader_assessment(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    return render(request, 'leader_assessment.html', locals())


def member_assessment(request, course_id):
    course = Course.objects.get(id=course_id)
    user = User.objects.get(id=request.user.id)
    return render(request, 'member_assessment.html', locals())

