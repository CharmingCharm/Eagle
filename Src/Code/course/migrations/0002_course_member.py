# Generated by Django 2.2.2 on 2020-04-30 04:13

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('course', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='member',
            field=models.ManyToManyField(to=settings.AUTH_USER_MODEL),
        ),
    ]
