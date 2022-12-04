from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from restApp.models import DataPoint, EEGData, Session
from restApp.serializers import DataPointSerializer
from restApp.serializers import FileUploadSerializer, SaveFileSerializer
import io, csv, pandas as pd

import logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@api_view(['GET', 'POST'])
def DataPointList(request):
    """
    List all data points or create a new one
    """
    if request.method == 'GET':
        '''
        DataPoints = DataPoint.objects.all()
        serializer = DataPointSerializer(DataPoints, many=True)
        return JsonResponse(serializer.data, safe=False)
        '''
        logger.info("something happened")
        #temporary static data point just to test api response
        point = {"idNum":"0",
                 "ch1":"1",
                 "ch2":"2",
                 "ch3":"3",
                 "ch4":"4",
                 "ch5":"5",
                 "ch6":"6",
                 "ch7":"7",
                 "ch8":"8",
                 "ch9":"9",
                 "ch10":"10",
                 "ch11":"11",
                 "ch12":"12",
                 "ch13":"13",
                 "ch14":"14"
                 }
        serializer = DataPointSerializer(point)
        return JsonResponse(serializer.data)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = DataPointSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@api_view(['GET', 'PUT', 'DELETE'])
def DataPointDetail(request, pk):
    """
    Getter, setter, or delete for a specific data point
    """
    try:
        point = DataPoint.objects.get(pk=pk)
    except DataPoint.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = DataPointSerializer(point)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = DataPointSerializer(point, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        point.delete()
        return HttpResponse(status=204)


class UploadFileView(generics.CreateAPIView):
    serializer_class = FileUploadSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        file = serializer.validated_data['file']
        reader = pd.read_csv(file)

        # session = Session(sampling_rate=128)
        # session.save()
        # logger.log("New Session ID: " + str(session.id))

        count = 0
        for idx, row in reader.iterrows():
            logger.info(str(idx))
            logger.info(str(row))
            count += 1
            if count > 20:
                break
        return Response({"status": "success"}, status.HTTP_201_CREATED)