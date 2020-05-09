from django.shortcuts import render, redirect
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

        deleteId = set()

        if request.session.get("deleteId") is not None:
            request.session.get("deleteId")
            deleteId = request.session.get("deleteId")
        
        if request.method == 'POST':
            request_data = json.loads(request.body)
            if request_data.get("deleteItemId") is not None:
                deleteId.add(int(request_data.get("deleteItemId")))
                request.session["deleteId"] = deleteId
                print(request.session["deleteId"])
                print(request.session.keys())
                submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
            else:
                submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')
            # if request_data.has_key('deleteItemId'):
            #     print("lala")
        else:
            submissionItem = SubmissionItem.objects.filter(course=course_id).exclude(id__in=deleteId).order_by('id')

        print(submissionItem)

        p = Paginator(submissionItem, 5)
        if p.num_pages <= 1:
            submissionItem_list = submissionItem
            data = ''
        else:
            page = int(request.GET.get('page', 1))
            submissionItem_list = p.page(page)
            left = []
            right = []
            left_has_more = False
            right_has_more = False
            first = False
            last = False
            total_pages = p.num_pages
            page_range = p.page_range
            if page == 1:
                right = page_range[page:page + 2]
                if right[-1] < total_pages - 1:
                    right_has_more = True
                if right[-1] < total_pages:
                    last = True
            elif page == total_pages:
                left = page_range[(page - 3) if (page - 3) > 0 else 0:page - 1]
                if left[0] > 2:
                    left_has_more = True
                if left[0] > 1:
                    first = True
            else:
                left = page_range[(page - 3) if (page - 3) > 0 else 0:page - 1]
                right = page_range[page:page + 2]
                if left[0] > 2:
                    left_has_more = True
                if left[0] > 1:
                    first = True
                if right[-1] < total_pages - 1:
                    right_has_more = True
                if right[-1] < total_pages:
                    last = True
            data = {
                'left': left,
                'right': right,
                'left_has_more': left_has_more,
                'right_has_more': right_has_more,
                'first': first,
                'last': last,
                'total_pages': total_pages,
                'page': page
            }
    
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