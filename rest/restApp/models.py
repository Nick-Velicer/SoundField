'''
A Django model representation for 
an EEG data point taken in by the api

Last edited by
Name: Nick Velicer
Date: 11/19
'''

from django.db import models


class DataPoint(models.Model):
    #index of location in timeseries (zero-index)
    idNum = models.IntegerField()
    #channel data at the specific index
    ch1 = models.FloatField()
    ch2 = models.FloatField()
    ch3 = models.FloatField()
    ch4 = models.FloatField()
    ch5 = models.FloatField()
    ch6 = models.FloatField()
    ch7 = models.FloatField()
    ch8 = models.FloatField()
    ch9 = models.FloatField()
    ch10 = models.FloatField()
    ch11 = models.FloatField()
    ch12 = models.FloatField()
    ch13 = models.FloatField()
    ch14 = models.FloatField()
    userId = models.IntegerField()

    class Meta:
        ordering = ['idNum']
