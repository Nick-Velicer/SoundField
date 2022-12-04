# Generated by Django 4.1.3 on 2022-12-04 20:44

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('restApp', '0002_datapoint_userid'),
    ]

    operations = [
        migrations.CreateModel(
            name='Session',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sampling_rate', models.IntegerField(default=128)),
            ],
        ),
        migrations.CreateModel(
            name='EEGData',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('row_num', models.IntegerField()),
                ('AF3', models.FloatField()),
                ('AF4', models.FloatField()),
                ('F3', models.FloatField()),
                ('F4', models.FloatField()),
                ('F7', models.FloatField()),
                ('F8', models.FloatField()),
                ('FC5', models.FloatField()),
                ('FC6', models.FloatField()),
                ('O1', models.FloatField()),
                ('O2', models.FloatField()),
                ('P7', models.FloatField()),
                ('P8', models.FloatField()),
                ('T7', models.FloatField()),
                ('T8', models.FloatField()),
                ('session_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='restApp.session')),
            ],
            options={
                'ordering': ['session_id', 'row_num'],
            },
        ),
    ]