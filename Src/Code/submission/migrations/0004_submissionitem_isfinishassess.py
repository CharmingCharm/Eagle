# Generated by Django 2.2.2 on 2020-05-12 05:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('submission', '0003_leaderassessment'),
    ]

    operations = [
        migrations.AddField(
            model_name='submissionitem',
            name='isFinishAssess',
            field=models.BooleanField(default=False),
        ),
    ]
