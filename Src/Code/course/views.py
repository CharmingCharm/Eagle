from django.shortcuts import render
from user.models import User
from .models import Course
from submission.models import SubmissionItem
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator


@csrf_exempt
def course_page(request, course_id):
    user = User.objects.get(id=request.user.id)
    course = Course.objects.get(id=course_id)
    submissionItem = SubmissionItem.objects.filter(course=course_id).order_by('id')

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

    return render(request, 'course.html', locals())


def generate_student(request, course_id):
    course = Course.objects.get(id=course_id)
    return render(request, 'generate_student.html', locals())


def import_student_excel(request, course_id):
    course = Course.objects.get(id=course_id)
    return render(request, 'import_student_excel.html', locals())


def import_student_individual(request, course_id):
    course = Course.objects.get(id=course_id)
    return render(request, 'import_student_individual.html', locals())