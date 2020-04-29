from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    field = models.CharField(max_length=20, blank=True, default="student")

    # isTeacher = models.BooleanField()


class Meta:
    verbose_name = 'User Profile'

    def __str__(self):
        return str(self.id)

class Teacher(models.Model):
    staffID = models.CharField(max_length=20, unique=False) # yaogai
    truename = models.CharField(max_length=20, unique=False)
    user = models.OneToOneField(User, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)



class Student(models.Model):
    studentID = models.CharField(max_length=20, unique=False)  # yaogai
    truename = models.CharField(max_length=20, unique=False)
    GPA = models.FloatField(default=0)
    user = models.OneToOneField(User, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)