from channels.generic.websocket import AsyncWebsocketConsumer
import json

class ProductConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.channel_layer.group_add("products", self.channel_name)
        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard("products", self.channel_name)

    async def receive(self, text_data):
        # optional: for clients to send updates
        pass

    async def send_new_product(self, event):
        await self.send(text_data=json.dumps({
            "type": "new_product",
            "product": event["product"]
        }))
