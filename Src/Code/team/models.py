from django.db import models
from user.models import User


class Team(models.Model):
    name = models.CharField(max_length=64, unique=False)
    # leader = models.OneToOneField(User, on_delete=models.DO_NOTHING)
    member = models.ManyToManyField(User)

    def __str__(self):
        return str(self.id)


class Leader(models.Model):
    team = models.OneToOneField(Team, on_delete=models.DO_NOTHING)
    bonus = models.IntegerField(default=0)

    def __str__(self):
        return str(self.id)
