from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import User, Product, Category, BiddingProduct
from django.forms.models import model_to_dict
import json
from django.contrib.auth import authenticate,login
import cloudinary.uploader
from decimal import Decimal
from django.db.models import Max

# Helper function for converting model instance to dictionary (JSON Response)
def model_to_dict_json(model_instance):
    return model_to_dict(model_instance)

# User register
@csrf_exempt
def register_user(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            if 'name' not in data or 'email' not in data or 'password' not in data:
                return JsonResponse({'error': 'Name, email, and password are required'}, status=400)

            name = data['name']
            email = data['email']
            password = data['password']

            if User.objects.filter(email=email).exists():
                return JsonResponse({'error': 'Email already in use'}, status=400)

            user = User.objects.create_user(name=name, email=email, password=password)

            return JsonResponse({'message': 'User created successfully', 'user': {'name': user.name}}, status=201)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON format'}, status=400)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

# Login login
@csrf_exempt
def login_user(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            if 'email' not in data or 'password' not in data:
                return JsonResponse({'error': 'Email and password are required'}, status=400)

            email = data['email']
            password = data['password']
            user = authenticate(email=email, password=password)

            if user:
                login(request, user)
                return JsonResponse({'message': 'Login successful', 'user': {'id': user.id,'role': user.role,'name': user.name, 'email': user.email}}, status=200)
            else:
                return JsonResponse({'error': 'Invalid email or password'}, status=401)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON format'}, status=400)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

# Login as seller
@csrf_exempt
def login_as_seller(request, id):
    try:
        user = get_object_or_404(User, id=id)

        if request.method == 'PUT':
            try:
                data = json.loads(request.body.decode('utf-8'))

                if 'email' not in data or 'password' not in data:
                    return JsonResponse({'error': 'Email and password are required'}, status=400)

                if user.email != data['email']:
                    return JsonResponse({'error': 'Email mismatch or user not found'}, status=404)

                user.role = data.get('role', user.role)
                user.save()

                return JsonResponse({'message': 'Role updated successfully', 'user': {'id': user.id, 'role': user.role}}, status=200)

            except json.JSONDecodeError:
                return JsonResponse({'error': 'Invalid JSON data'}, status=400)

    except User.DoesNotExist:
        return JsonResponse({'error': 'User not found'}, status=404)

# User List
@csrf_exempt
def user_list(request):
    if request.method == 'GET':
        users = User.objects.all()
        users_list = []

        for user in users:
            user_data = model_to_dict(user)
            user_data['created_at'] = user.date_joined.strftime("%Y-%m-%d")
            users_list.append(user_data)

        return JsonResponse(users_list, safe=False, status=200)

    if request.method == 'POST':
        data = json.loads(request.body)

        # Ensure required fields are present
        if 'name' not in data or 'email' not in data or 'password' not in data:
            return JsonResponse({'error': 'Name, email, and password are required'}, status=400)

        # Create the user instance
        user = User.objects.create_user(
            name=data['name'],
            email=data['email'],
            password=data['password']
        )
        return JsonResponse(model_to_dict_json(user), status=201)

# User Detail
@csrf_exempt
def user_detail(request, id):
    user = get_object_or_404(User, id=id)

    if request.method == 'GET':
        return JsonResponse(model_to_dict_json(user), status=200)

    if request.method == 'PUT':
        try:
            data = json.loads(request.body.decode('utf-8'))
            if 'name' not in data or 'email' not in data:
                return JsonResponse({'error': 'Name and email are required'}, status=400)
            user.name = data.get('name', user.name)
            user.contact_number = data.get('contact_number', user.contact_number)
            user.email = data.get('email', user.email)
            user.photo = data.get('photo', user.photo)
            user.save()

            return JsonResponse({'message': 'User updated successfully'}, status=200)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON data'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'error': 'User not found'}, status=404)

    if request.method == 'DELETE':
        user.delete()
        return JsonResponse({'message': 'User deleted'}, status=204)

# count user
def user_count(request):
    users = User.objects.all()

    if request.method == 'GET':
        user_count = users.count()
        return JsonResponse({"user_count": user_count}, status=200)

# upload image
@csrf_exempt
def upload_image(request):
    if request.method == "POST" and request.FILES.get("photo"):
        uploaded_file = request.FILES["photo"]
        result = cloudinary.uploader.upload(uploaded_file)
        return JsonResponse({"url": result["secure_url"]})
    return JsonResponse({"error": "Invalid request"}, status=400)

# Get Product List by product ID
@csrf_exempt
def getProductListById(request,id):
    if request.method == 'GET':
        products = Product.objects.filter(id=id)
        products_list = {}

        for product in products:
            bids = BiddingProduct.objects.filter(product=product)
            total_bids = sum(bid.price for bid in bids)

            product_dict = model_to_dict(product)
            if product.end_date:
              product_dict['end_date'] = product.end_date.strftime("%B %d, %Y %I:%M %p")
            product_dict['max_price_bid']  = max((bid.price for bid in bids), default=0)
            product_dict['created_at'] = product.created_at.strftime("%B %d, %Y %I:%M %p")
            product_dict['updated_at'] = product.updated_at.strftime("%B %d, %Y %I:%M %p")
            product_dict['total_bids'] = total_bids
            products_list.update(product_dict)

        return JsonResponse(products_list, safe=False, status=200)

# Get Product list with bidding
def getProductListWithBidding(request):
    if request.method == 'GET':
        products = Product.objects.all()
        products_list = []

        for product in products:
            bids = BiddingProduct.objects.filter(product=product)
            total_bids = sum(bid.price for bid in bids)
            product_dict = model_to_dict(product)
            product_dict['total_bids'] = total_bids
            product_dict['max_price_bid'] = max((bid.price for bid in bids), default=0)
            products_list.append(product_dict)

        return JsonResponse(products_list, safe=False, status=200)

# Create and Get Product List
@csrf_exempt
def product_list(request):
    if request.method == 'GET':
        products = Product.objects.all()
        products_list = [model_to_dict_json(product) for product in products]
        return JsonResponse(products_list, safe=False, status=200)

    if request.method == 'POST':
      data = json.loads(request.body)

      # Validate required fields
      required_fields = ['title', 'price', 'description', 'category', 'user_id']
      for field in required_fields:
          if field not in data or data[field] is None:
              return JsonResponse({'error': f'{field.capitalize()} is required'}, status=400)

      # Ensure user exists
      user = User.objects.filter(id=data['user_id']).first()
      if not user:
          return JsonResponse({'error': 'User does not exist'}, status=400)

      # Ensure category exists
      category_id = data['category']
      category = Category.objects.filter(id=category_id).first()
      if not category:
            return JsonResponse({'error': 'Category does not exist'}, status=400)

      # Create the product
      product = Product.objects.create(
          title=data['title'],
          description=data['description'],
          price=data['price'],
          height=data.get('height'),
          lengthpic=data.get('lengthpic'),
          width=data.get('width'),
          mediumused=data.get('mediumused'),
          weight=data.get('weight'),
          category=category,
          user=user,
          image=data['image']
      )

      return JsonResponse({'message': "Create Product Successfully"}, status=201)


@csrf_exempt
def product_by_user_id(request, id):
    products = Product.objects.filter(user_id=id)
    if request.method == 'GET':
        if not products.exists():
            return JsonResponse({'error': 'No products found for this user'}, status=404)

        products_list = []
        for product in products:
            product_dict = model_to_dict_json(product)
            top_bid = BiddingProduct.objects.filter(product=product).order_by('-price').select_related('user').first()
            if top_bid:
                product_dict['max_price_bid'] = top_bid.price
                product_dict['user_win'] = top_bid.user.name
            else:
                product_dict['max_price_bid'] = 0
                product_dict['user_win'] = None
            products_list.append(product_dict)
        return JsonResponse(products_list, safe=False, status=200)

# count product by user id
def product_count_by_user_id(request, id):
    products = Product.objects.filter(user_id=id)

    if request.method == 'GET':
        product_count = products.count()
        return JsonResponse({"product_count": product_count}, status=200)

# sum product by user id
def sumAmountUserId(request, id):
    products = Product.objects.filter(user_id=id)

    if request.method == 'GET':
        amount_count = sum(product.price for product in products)
        return JsonResponse({"amounts": amount_count}, status=200)

# sum product by admin
def sumAmountAdmin(request):
    products = Product.objects.all()

    if request.method == 'GET':
        amount_count = sum(product.price for product in products)
        return JsonResponse({"amounts": amount_count}, status=200)

# sum commission product by admin
def sumCommissionByAdmin(request):
    products = Product.objects.all()

    if request.method == 'GET':
        amount_count = sum(product.commission for product in products)
        return JsonResponse({"commissions": amount_count}, status=200)

# get all product
def product_counts(request):
    products = Product.objects.all()

    if request.method == 'GET':
        product_count = products.count()
        return JsonResponse({"product_counts": product_count}, status=200)

@csrf_exempt
def product_detail(request, id):
    product = get_object_or_404(Product, id=id)

    if request.method == 'GET':
        return JsonResponse(model_to_dict_json(product), status=200)

    if request.method == 'PUT':
        data = json.loads(request.body)
        product.title = data.get('title', product.title)
        product.slug = data.get('slug', product.slug)
        product.description = data.get('description', product.description)
        product.price = float(data.get('price', product.price))
        product.height = float(data.get('height', product.height))
        product.lengthpic = float(data.get('lengthpic', product.lengthpic))
        product.width = float(data.get('width', product.width))
        product.mediumused = data.get('mediumused', product.mediumused)
        product.weight = float(data.get('weight', product.weight))
        product.category = data.get('category', product.category)
        product.image = data.get('image', product.image)

        product.save()
        return JsonResponse({'message': 'Update Product Successfully'}, status=200)

    if request.method == 'DELETE':
        product_bid = BiddingProduct.objects.filter(product=product)
        if product_bid:
            return JsonResponse({'error': 'Product is already bid'}, status=404)
        product.delete()
        return JsonResponse({'message': 'Product deleted'}, status=200)

@csrf_exempt
def update_product_by_admin(request,id):
    product = get_object_or_404(Product, id=id)
    if request.method == "PUT":
        data = json.loads(request.body)
        original_price = product.price
        commission_rate = data['commission']
        commission_price = (Decimal(commission_rate) / 100) * original_price
        product.commission = commission_price
        product.isverify = 1 if commission_rate != 0 else 0
        product.start_date = data['start_date']
        product.end_date = data['end_date']
        product.save()
        return JsonResponse({"message": "Update Product Successfully"}, status=200)

# Sold to user by hight amount bidding
@csrf_exempt
def soldProductWithHeightBid(request,id):
    product = get_object_or_404(Product, id=id)
    highest_bid  = BiddingProduct.objects.filter(product=product).order_by('-price').first()
    if request.method == "PUT":
        if highest_bid:
            product.sold_to = highest_bid.user
            highest_bid.is_win = 1
            product.is_soldout = True
            product.save()
            highest_bid.save()

            return JsonResponse({"message": "Product sold successfully"}, status=200)
        else:
            return JsonResponse({"error": "No bids found for this product"}, status=400)

# auto sold
@csrf_exempt
def AutoSoldProductWithHeightBid(request,id):
    product = get_object_or_404(Product, id=id)
    highest_bid  = BiddingProduct.objects.filter(product=product).order_by('-price').first()
    if request.method == "PUT":
        if highest_bid:
            product.sold_to = highest_bid.user
            highest_bid.is_auto_bid = 1
            highest_bid.is_win = 1
            product.is_soldout = True
            product.save()
            highest_bid.save()

            return JsonResponse({"message": "Product sold successfully"}, status=200)
        else:
            return JsonResponse({"error": "No bids found for this product"}, status=400)


# Category CRUD operations
@csrf_exempt
def category_list(request):
    if request.method == 'GET':
        users = User.objects.all()
        categories = Category.objects.all()
        response_data = []

        for user in users:
            user_categories = user.categories.all()
            for category in user_categories:
                response_data.append({
                    'id' : category.id,
                    'photo': user.photo,
                    'date': category.created_at.strftime('%Y-%m-%d'),
                    'user_name': user.name,
                    'email': user.email,
                    'password': user.password,
                    'category_title': category.title
                })

        return JsonResponse(response_data, safe=False, status=200)

    if request.method == 'POST':
        try:
            data = json.loads(request.body)

            if 'title' not in data or 'user_id' not in data:
                return JsonResponse({'error': 'Title are required'}, status=400)

            title = data['title']
            user_id = data['user_id']

            categories = Category.objects.filter(title=title).first()
            if categories:
                 return JsonResponse({'error': 'Category Already Exit'}, status=404)

            user = User.objects.filter(id=user_id).first()
            if user is None:
                return JsonResponse({'error': 'User not found'}, status=404)

            category = Category.objects.create(title=title, user=user)
            return JsonResponse({'message': 'Category created successfully'}, status=201)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON format'}, status=400)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
def category_detail(request, id):
    category = get_object_or_404(Category, id=id)

    if request.method == 'GET':
        return JsonResponse(model_to_dict_json(category), status=200)

    if request.method == 'PUT':
        data = json.loads(request.body)
        categories = Category.objects.filter(title=data['title']).first()
        if categories:
              return JsonResponse({'error': 'Category Already Exit'}, status=404)
        category.title = data['title']
        category.save()
        return JsonResponse({'message': 'Category Update Successfully'}, status=200)

    if request.method == 'DELETE':
        if Product.objects.filter(category=category).exists():
            return JsonResponse({'error': 'Category is associated with a product'}, status=400)
        category.delete()
        return JsonResponse({'message': 'Category deleted'}, status=204)

# BiddingProduct list get and create
@csrf_exempt
def bidding_product_list(request):
    if request.method == 'GET':
        bidding_products = BiddingProduct.objects.all()
        bidding_products_list = [model_to_dict_json(bidding_product) for bidding_product in bidding_products]
        return JsonResponse(bidding_products_list, safe=False, status=200)

    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            if 'user_id' not in data or 'product_id' not in data or 'price' not in data:
                return JsonResponse({'message': 'Missing required fields: user_id, product_id, price'}, status=400)

            user = User.objects.filter(id=data['user_id']).first()
            product = Product.objects.filter(id=data['product_id']).first()

            # Create BiddingProduct
            bidding_product = BiddingProduct.objects.create(
                user_id=user.id,
                product_id=product.id,
                price=data['price'],
            )

            return JsonResponse({'message': 'Bid added successfully'}, status=201)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
def bidding_product_detail(request, id):
    bidding_product = get_object_or_404(BiddingProduct, id=id)

    if request.method == 'GET':
        return JsonResponse(model_to_dict_json(bidding_product), status=200)

    if request.method == 'PUT':
        data = json.loads(request.body)
        bidding_product.price = data['price']
        bidding_product.save()
        return JsonResponse(model_to_dict_json(bidding_product), status=200)

    if request.method == 'DELETE':
        bidding_product.delete()
        return JsonResponse({'message': 'Bidding Product deleted'}, status=204)

# get Product bidding with product id
@csrf_exempt
def biddingByProductId(request, id):
    if request.method == 'GET':
        try:
            bids = BiddingProduct.objects.filter(product_id=id).select_related('user','product')
            if not bids:
                return JsonResponse({'error': 'No bids found for this product'}, status=404)
            bids_list = []
            for bid in bids:
                bids_list.append({
                    'is_soldout': bid.product.is_soldout,
                    'is_auto_bid': bid.is_auto_bid,
                    'is_win': bid.is_win,
                    'user_name': bid.user.name,
                    'bid_price': bid.price,
                    'bid_date': bid.created_at.strftime("%B %d, %Y %I:%M %p"),
                })

            return JsonResponse(bids_list, safe=False, status=200)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

# Get all bidding
@csrf_exempt
def getAllBidding(request):
    if request.method == 'GET':
        try:
            top_bids = (
                BiddingProduct.objects
                # .filter(product__is_soldout=False)
                .values('product_id')
                .annotate(max_price=Max('price'))
            )

            winning_bids = []
            for bid_info in top_bids:
                product_id = bid_info['product_id']
                max_price = bid_info['max_price']

                winning_bid = (
                    BiddingProduct.objects
                    .filter(product_id=product_id, price=max_price)
                    .select_related('user', 'product')
                    .first()
                )

                if winning_bid:
                    winning_bids.append({
                        'bid_id' : winning_bid.id,
                        'product_name': winning_bid.product.title,
                        'user_name': winning_bid.user.name,
                        'bid_price': winning_bid.price,
                        'bid_date': winning_bid.created_at.strftime("%B %d, %Y %I:%M %p"),
                    })

            if not winning_bids:
                return JsonResponse({'error': 'No winning bids found'}, status=404)

            return JsonResponse(winning_bids, safe=False, status=200)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

# Get all bidding by user winning id
@csrf_exempt
def getAllBiddingByUser(request, id):
    if request.method == 'GET':
        try:
            winning_bids = (
                BiddingProduct.objects
                .filter(user_id=id, product__sold_to_id=id)
                .select_related('user', 'product')
                .order_by('-created_at')
            )

            if not winning_bids.exists():
                return JsonResponse({'error': 'No winning bids found for this user'}, status=404)

            result = []
            for bid in winning_bids:
                result.append({
                    'bid_id': bid.id,
                    'product_id': bid.product.id,
                    'product_name': bid.product.title,
                    'user_name': bid.user.name,
                    'bid_price': bid.price,
                    'bid_date': bid.created_at.strftime("%B %d, %Y %I:%M %p"),
                })

            return JsonResponse(result, safe=False, status=200)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
