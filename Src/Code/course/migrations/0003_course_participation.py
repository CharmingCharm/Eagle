# Generated by Django 2.2.2 on 2020-04-30 07:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('course', '0002_course_member'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='participation',
            field=models.IntegerField(default=0),
        ),
    ]
