# Generated by Django 2.2.2 on 2020-05-12 14:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('team', '0009_invitation'),
        ('submission', '0005_submissioncontribution_team'),
    ]

    operations = [
        migrations.AddField(
            model_name='leaderassessment',
            name='team',
            field=models.ForeignKey(default=2, on_delete=django.db.models.deletion.CASCADE, to='team.Team'),
            preserve_default=False,
        ),
    ]
