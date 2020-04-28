from django.db import models
from user.models import User


class SubmissionItem(models.Model):
    title = models.CharField(max_length=64, unique=False)
    percentage = models.FloatField(default=0)
    course = models.ForeignKey("Course", on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)


class SubmissionContribution(models.Model):
    value = models.FloatField(default=0)
    member = models.ForeignKey("User", on_delete=models.DO_NOTHING)
    submission = models.ForeignKey("SubmissionItem", on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)
