'''
A serializer for the DataPoint EEG representation
that allows transfer to the JSON format from our model

Last edited by
Name: Nick Velicer
Date: 11/19
'''

from rest_framework import serializers
from api.models import DataPoint, EEGData


class DataPointSerializer(serializers.ModelSerializer):
    class Meta:
        model = DataPoint
        fields = ['id', 
                  'idNum', 
                  'ch1',
                  'ch2',
                  'ch3',
                  'ch4',
                  'ch5',
                  'ch6',
                  'ch7',
                  'ch8',
                  'ch9',
                  'ch10',
                  'ch11',
                  'ch12',
                  'ch13',
                  'ch14']

class FileUploadSerializer(serializers.Serializer):
    """
    Serializer to transfer the file to the backend.
    """
    file = serializers.FileField()

class SaveFileSerializer(serializers.Serializer):
    """
    Each row of data from the csv will go through this 
    serializer and validate it has all the right values.
    """
    class Meta:
        model = EEGData
        fields = "__all__"