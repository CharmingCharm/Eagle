from django.db import models
from user.models import User
from course.models import Course
from team.models import Team

class SubmissionItem(models.Model):
    title = models.CharField(max_length=64, unique=False)
    percentage = models.FloatField(default=0)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)


class SubmissionContribution(models.Model):
    value = models.FloatField(default=0)
    member = models.ForeignKey(User, on_delete=models.DO_NOTHING)
    submission = models.ForeignKey(SubmissionItem, on_delete=models.CASCADE)
    isFinishAssess = models.BooleanField(default=False)
    team = models.ForeignKey(Team, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)

class LeaderAssessment(models.Model):
    member = models.IntegerField(default=0)
    leader = models.IntegerField(default=0)
    mark = models.FloatField(default=0)
    team = models.ForeignKey(Team, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)


        # if not request.session.has_key('curr_sub'):
        #         submissionItem = SubmissionItem.objects.filter(course=course_id).order_by('id')
        #         request.session['curr_sub'] = [[], []]
        #         x = 0
        #         for submission in submissionItem:
        #             request.session['curr_sub'][0].append({'index': x,'id': submission.id, 'title': submission.title, 'percentage': submission.percentage})
        #             x = x + 1
        
        # print(request.session['curr_sub'])
        # showupLists = request.session['curr_sub'][0]
        # deleteLists = request.session['curr_sub'][1]


        # if request.method == 'POST':
        #     formSet = ModifySubListSet(request.POST)
        #     if formSet.is_valid():
        #         deleteLists.append(showupLists.pop(int(request.POST.get('deleteItem'))))
        #         request.session['curr_sub'][0] = showupLists
        #         request.session['curr_sub'][1] = deleteLists
        #         print(request.session['curr_sub'])

        # print("lala")