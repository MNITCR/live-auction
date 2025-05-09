# backend/routing.py
from django.urls import re_path
from api import consumers

websocket_urlpatterns = [
    re_path(r"ws/products/$", consumers.ProductConsumer.as_asgi()),
]
