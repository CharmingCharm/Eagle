from django.db import models
from user.models import User

class Course(models.Model):
    name = models.CharField(max_length=64, unique=False)
    begin_time = models.DateTimeField(auto_now_add=True)
    end_time = models.DateTimeField(auto_now_add=True)
    # category = models.ForeignKey(Category, on_delete=models.DO_NOTHING, null=False)
    form_method = models.IntegerField(default=0, unique=False)
    pic = models.CharField(max_length=64, unique=False, default='default.jpg')
    visit = models.IntegerField(default=0, unique=False)
    description = models.CharField(max_length=256, unique=False)
    participation = models.IntegerField(default=0)
    team_size_1 = models.IntegerField(default=0)
    team_number_1 = models.IntegerField(default=0)
    team_size_2 = models.IntegerField(default=0)
    team_number_2 = models.IntegerField(default=0)

    member = models.ManyToManyField(User)

    def __str__(self):
        return str(self.id)


class ExportFile(models.Model):
    student = models.ForeignKey(User, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    contribution = models.FloatField(default=0)
    bonus = models.FloatField(default=0)

    def __str__(self):
        return str(self.id)