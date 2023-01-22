'''
Specified URLs to make api requests, specified by
going to localhost:8000/desiredpath after running
"python manage.py runserver 8000" 

Last edited by
Name: Nick Velicer
Date: 11/19
'''

from django.urls import path
from api import views

urlpatterns = [
    path('', views.DataPointList),
    path('<int:pk>/', views.DataPointDetail),
    path('upload/', views.UploadFileView.as_view(), name='upload-file')
]