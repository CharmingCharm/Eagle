from django.db import models
from user.models import User
from course.models import Course


class Leader(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    bonus = models.IntegerField(default=0)

    def __str__(self):
        return str(self.id)


class Team(models.Model):
    name = models.CharField(max_length=64, unique=False)
    # leader = models.OneToOneField(Leader, on_delete=models.CASCADE)
    member = models.ManyToManyField(User)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)



