from django.shortcuts import render, redirect
from .forms import AddSubmissionItemForm
from course.models import Course
from submission.models import SubmissionItem
from user.models import User
from django.contrib.auth import authenticate, logout, login
from django.contrib import messages


def add_submission(request, course_id):
    if request.user.is_authenticated:
        if request.method == 'POST':
            add_submission_form = AddSubmissionItemForm(request.POST)
            if add_submission.is_valid():
                title = add_submission_form.cleaned_data['title']
                percentage = add_submission_form.cleaned_data['percentage']
                course = Course.objects.get(id=course_id)
                submission_dup = SubmissionItem.objects.get(title=title)
                if not submission_dup:
                    submission_new = SubmissionItem.objects.create(title=title,percentage=percentage)
                    submission_new.save()
                    messages.add_message(request, messages.SUCCESS, 'Add submission item succeed!')
                    return redirect('/course/'+course_id)
                messages.add_message(request, messages.ERROR, 'The title of the submission item exists!')
                return redirect('/course/'+course_id+'/add_submission/')
        add_submission_form = AddSubmissionItemForm()
        return render(request, 'add_submission_item.html', locals())
    return redirect('/')


def modify_submission(request, course_id):
    course = Course.objects.get(id=course_id)
    return render(request, 'modify_submission.html', locals())