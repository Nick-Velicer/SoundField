# Generated by Django 4.1.3 on 2022-11-20 00:49

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Datapoint',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('idNum', models.IntegerField()),
                ('ch1', models.FloatField()),
                ('ch2', models.FloatField()),
                ('ch3', models.FloatField()),
                ('ch4', models.FloatField()),
                ('ch5', models.FloatField()),
                ('ch6', models.FloatField()),
                ('ch7', models.FloatField()),
                ('ch8', models.FloatField()),
                ('ch9', models.FloatField()),
                ('ch10', models.FloatField()),
                ('ch11', models.FloatField()),
                ('ch12', models.FloatField()),
                ('ch13', models.FloatField()),
                ('ch14', models.FloatField()),
            ],
            options={
                'ordering': ['idNum'],
            },
        ),
    ]
