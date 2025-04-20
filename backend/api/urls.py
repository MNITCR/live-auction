from django.urls import path
from . import views

urlpatterns = [
    # User
    path('register', views.register_user, name='register'),
    path('login', views.login_user, name='login'),
    path('users', views.user_list, name='user-list'),
    path('users/<int:id>', views.user_detail, name='user-detail'),
    path("users/upload", views.upload_image, name="upload_image"),
    path("user_count", views.user_count, name="user-count"),
    path("login_as_seller/<int:id>", views.login_as_seller, name="login-as-seller"),

    # Product
    path('products', views.product_list, name='product-list'),
    path('get_product_list_with_bid', views.getProductListWithBidding, name='get_product_list_with_bid'),
    path('get_product_by_id/<int:id>', views.getProductListById, name='get_product_by_id'),
    path('products/<int:id>', views.product_detail, name='product-detail'),
    path('product_by_user/<int:id>', views.product_by_user_id, name='product_by_user'),
    path('product_count_by_user/<int:id>', views.product_count_by_user_id, name='product_count_by_user'),
    path('product_counts', views.product_counts, name='product_counts'),
    path('sum_amount_by_user/<int:id>', views.sumAmountUserId, name='sum_amount_by_user'),
    path('sum_amount_by_admin', views.sumAmountAdmin, name='sum_amount_by_admin'),
    path('sum_commission_by_admin', views.sumCommissionByAdmin, name='sum_commission_by_admin'),
    path('product_update_by_admin/<int:id>', views.update_product_by_admin, name='product_update_by_admin'),
    path('product_sold/<int:id>', views.soldProductWithHeightBid, name='product_sold'),
    path('product_auto_sold/<int:id>', views.AutoSoldProductWithHeightBid, name='product_auto_sold'),

    # Category
    path('categories', views.category_list, name='category-list'),
    path('categories/<int:id>', views.category_detail, name='category-detail'),

    # BiddingProduct
    path('bidding-products', views.bidding_product_list, name='bidding-product-list'),
    path('bidding-products/<int:id>', views.bidding_product_detail, name='bidding-product-detail'),
    path('bidding_by_product_id/<int:id>', views.biddingByProductId, name='bidding-product-detail'),
    path('bidding_products', views.getAllBidding, name='all_bidding'),
    path('bidding_by_user/<int:id>', views.getAllBiddingByUser, name='all_bidding_by_user'),
]
