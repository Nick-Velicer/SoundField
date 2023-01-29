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


class Session(models.Model):
    """
    This Class is used to create a new session (new file upload).
    Each EEGData row will point to a particular session. Session 
    will also store the sampling rate and other high level information
    about the eeg recording session as we see fit.
    """
    sampling_rate = models.IntegerField(default=128)


class EEGData(models.Model):
    """
    This Class is used to serialize the data from the raw EEG files.
    Meaning, each EEGData record is one row in an EEG file. We will be
    referencing the files through the session_id foreign key.
    """
    session_id = models.ForeignKey(Session, on_delete=models.CASCADE)
    row_num = models.IntegerField()
    AF3 = models.FloatField()
    AF4 = models.FloatField()
    F3 = models.FloatField()
    F4 = models.FloatField()
    F7 = models.FloatField()
    F8 = models.FloatField()
    FC5 = models.FloatField()
    FC6 = models.FloatField()
    O1 = models.FloatField()
    O2 = models.FloatField()
    P7 = models.FloatField()
    P8 = models.FloatField()
    T7 = models.FloatField()
    T8 = models.FloatField()

    class Meta:
        ordering = ['session_id', 'row_num']