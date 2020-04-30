# Generated by Django 2.2.2 on 2020-04-30 04:13

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Course',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=64)),
                ('begin_time', models.DateTimeField(auto_now_add=True)),
                ('end_time', models.DateTimeField(auto_now_add=True)),
                ('form_method', models.CharField(max_length=64)),
                ('pic', models.CharField(default='default.jpg', max_length=64)),
                ('visit', models.IntegerField(default=0)),
                ('description', models.CharField(max_length=256)),
            ],
        ),
    ]
