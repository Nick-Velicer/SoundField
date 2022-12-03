from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
from restApp.models import DataPoint
from restApp.serializers import DataPointSerializer


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