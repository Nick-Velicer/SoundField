'''
Specified URLs to make api requests, specified by
going to localhost:8000/desiredpath after running
"python manage.py runserver 8000" 

Last edited by
Name: Nick Velicer
Date: 11/19
'''

from django.urls import path
from restApp import views

urlpatterns = [
    path('restApp/', views.DataPointList),
    path('restApp/<int:pk>/', views.DataPointDetail),
]