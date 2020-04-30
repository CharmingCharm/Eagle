# Generated by Django 2.2.2 on 2020-04-30 04:13

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('team', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='team',
            name='member',
            field=models.ManyToManyField(to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='leader',
            name='team',
            field=models.OneToOneField(on_delete=django.db.models.deletion.DO_NOTHING, to='team.Team'),
        ),
    ]
