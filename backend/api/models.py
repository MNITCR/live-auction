from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.utils.translation import gettext_lazy as _
from django.contrib.auth import get_user_model
from django.utils.text import slugify

# Custom User Manager for creating users with custom fields (e.g., for custom validations or password handling)
class CustomUserManager(BaseUserManager):
    def create_user(self, name, email, password=None, **extra_fields):
        if not email:
            raise ValueError(_('The Email field must be set'))
        email = self.normalize_email(email)
        user = self.model(name=name, email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, name, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(name, email, password, **extra_fields)

class User(AbstractBaseUser):
    name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    photo = models.URLField(default="https://cdn-icons-png.flaticon.com/512/2202/2202112.png")

    class Role(models.TextChoices):
        ADMIN = 'admin', _('Admin')
        SELLER = 'seller', _('Seller')
        BUYER = 'buyer', _('Buyer')

    role = models.CharField(max_length=6, choices=Role.choices, default=Role.BUYER)
    commission_balance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    balance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    contact_number = models.CharField(max_length=100, null=True, blank=True)
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now=True)

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name']

    def __str__(self):
        return self.email

# Product model
User = get_user_model()
class Product(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='products',to_field='id')
    title = models.CharField(max_length=255)
    slug = models.SlugField(unique=True)
    description = models.TextField()
    image = models.CharField(max_length=255, null=True, blank=True)
    category = models.CharField(max_length=100, default="All")
    commission = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    height = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    lengthpic = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    width = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    mediumused = models.CharField(max_length=100, null=True, blank=True)
    weight = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    isverify = models.BooleanField(default=False)
    is_soldout = models.BooleanField(default=False)
    sold_to = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='purchased_products')
    start_date = models.DateTimeField(null=True,blank=True)
    end_date = models.DateTimeField(null=True,blank=True)

    # Timestamps are automatically added by Django
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        # Generate slug from title if not provided
        if not self.slug:
            self.slug = slugify(self.title)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title

# Category model
User = get_user_model()
class Category(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='categories')
    title = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

# bidding product model
User = get_user_model()
class BiddingProduct(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='bidding_products')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='bidding_products')
    is_auto_bid = models.BooleanField(default=False)
    is_win = models.BooleanField(default=False)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user} bidding on {self.product} at {self.price}"
