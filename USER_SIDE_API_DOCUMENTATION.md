# GARJA E-COMMERCE - USER SIDE API DOCUMENTATION

## Base URL
```
https://api.mygarja.com
```

## Authentication
Include JWT token in Authorization header for protected endpoints:
```
Authorization: Bearer <jwt_token>
```

---

## 🔐 AUTHENTICATION ENDPOINTS

### 1. User Registration
**POST** `/auth/signup` (No Auth Required)

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123",
  "firstName": "John",
  "lastName": "Doe",
  "phoneNumber": "+1234567890",
  "role": "USER",
  "provider": "LOCAL"
}
```

**Response (201):**
```json
{
  "id": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "phoneNumber": "+1234567890",
  "role": "USER",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### 2. User Login
**POST** `/auth/login` (No Auth Required)

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200):**
```json
{
  "id": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "role": "USER"
}
```

### 3. Google OAuth Login
**GET** `/auth/google` (No Auth Required)
- Redirects to Google OAuth authorization

### 4. Google OAuth Callback
**POST** `/auth/google/callback` (No Auth Required)

**Request:**
```json
{
  "userInfo": {
    "id": "google_user_id",
    "email": "user@gmail.com",
    "given_name": "John",
    "family_name": "Doe",
    "picture": "profile_url"
  }
}
```

**Response (200):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "message": "Authentication successful"
}
```

---

## 👤 USER PROFILE ENDPOINTS

### 1. Get Profile
**GET** `/common/showProfile` (Auth Required)

**Response (200):**
```json
{
  "id": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "phoneNumber": "+1234567890",
  "role": "USER"
}
```

### 2. Update Password
**PUT** `/common/updatePassword` (Auth Required)

**Request:**
```json
{
  "email": "user@example.com",
  "password": "newPassword123",
  "firstName": "John",
  "lastName": "Doe",
  "phoneNumber": "+1234567890",
  "role": "USER",
  "provider": "LOCAL"
}
```

### 3. Reset Password
**POST** `/common/reset-password` (Auth Required)

**Request:**
```json
{
  "newPassword": "newPassword123",
  "confirmPassword": "newPassword123"
}
```

**Response (200):**
```json
{
  "message": "Password reset successful",
  "success": true
}
```

---

## 🏠 ADDRESS MANAGEMENT

### 1. Add Address
**POST** `/user/address/add` (Auth Required)

**Request:**
```json
{
  "steet": "123 Main St",
  "city": "New York",
  "landmark": "Near Park",
  "pincode": "10001",
  "address": "Apt 4B, 123 Main St"
}
```

**Response (200):**
```json
{
  "id": 1,
  "steet": "123 Main St",
  "city": "New York",
  "landmark": "Near Park",
  "pincode": "10001",
  "address": "Apt 4B, 123 Main St"
}
```

### 2. Get User Addresses
**GET** `/user/address/byUser` (Auth Required)

**Response (200):**
```json
[
  {
    "id": 1,
    "steet": "123 Main St",
    "city": "New York",
    "landmark": "Near Park",
    "pincode": "10001",
    "address": "Apt 4B, 123 Main St"
  }
]
```

### 3. Delete Address
**DELETE** `/user/address/{id}` (Auth Required)
- Returns 204 No Content

---

## 🛒 CART MANAGEMENT

### 1. Add to Cart
**POST** `/user/cart/add/{productId}?quantity=2` (Auth Required)

**Response (200):**
```json
{
  "id": 1,
  "userId": 1,
  "items": [
    {
      "id": 1,
      "productId": 5,
      "productName": "T-Shirt",
      "price": 25.99,
      "quantity": 2,
      "size": "M",
      "imageUrl": "image_url",
      "totalPrice": 51.98
    }
  ],
  "totalAmount": 51.98,
  "totalItems": 2
}
```

### 2. Get Cart
**GET** `/user/cart` (Auth Required)
- Returns same structure as Add to Cart

### 3. Remove from Cart
**DELETE** `/user/cart/remove/{productId}` (Auth Required)
- Returns updated cart structure

### 4. Update Quantity
**PUT** `/user/cart/update/{productId}?quantity=3` (Auth Required)
- Returns updated cart structure

### 5. Update Size
**PUT** `/user/cart/size/{productId}?size=L` (Auth Required)
- Returns updated cart structure

### 6. Clear Cart
**DELETE** `/user/cart/clear` (Auth Required)

**Response (200):**
```json
"Cart cleared successfully"
```

---

## 📦 ORDER MANAGEMENT

### 1. Buy Now
**POST** `/user/orders/buy-now` (Auth Required)

**Request:**
```json
{
  "productId": 5,
  "quantity": 2,
  "size": "M"
}
```

**Response (200):**
```json
{
  "id": 101,
  "orderDate": "2024-01-15",
  "totalAmount": 51.98,
  "status": "PENDING",
  "productName": "T-Shirt",
  "quantity": 2,
  "size": "M",
  "image": "image_url",
  "userId": 1,
  "message": "Order placed successfully"
}
```

### 2. Checkout Cart
**POST** `/user/orders/checkout?addressId=1` (Auth Required)

**Response (200):**
```json
{
  "id": 102,
  "orderDate": "2024-01-15",
  "totalAmount": 139.97,
  "status": "PENDING",
  "productName": "Multiple Items",
  "quantity": 3,
  "size": "Various",
  "image": "cart_image",
  "userId": 1,
  "message": "Order placed successfully"
}
```

### 3. Create Razorpay Order
**POST** `/user/orders/create-razorpay-order` (Auth Required)

**Request:**
```json
{
  "amount": 2500,
  "currency": "INR",
  "receipt": "order_123"
}
```

**Response (200):**
```json
{
  "id": "order_razorpay_id",
  "amount": 2500,
  "currency": "INR",
  "receipt": "order_123",
  "status": "created"
}
```

### 4. Verify Payment
**POST** `/user/orders/verify-payment?addressId=1` (Auth Required)

**Request:**
```json
{
  "razorpay_order_id": "order_id",
  "razorpay_payment_id": "payment_id",
  "razorpay_signature": "signature"
}
```

**Response (200):**
```json
{
  "id": 103,
  "orderDate": "2024-01-15",
  "totalAmount": 25.00,
  "status": "PAID",
  "productName": "T-Shirt",
  "quantity": 1,
  "size": "M",
  "image": "image_url",
  "userId": 1,
  "message": "Payment verified and order created"
}
```

### 5. Get Order History
**GET** `/user/orders/history` (Auth Required)

**Response (200):**
```json
[
  {
    "id": 101,
    "orderDate": "2024-01-15",
    "totalAmount": 51.98,
    "status": "DELIVERED",
    "productName": "T-Shirt",
    "quantity": 2,
    "size": "M",
    "image": "image_url",
    "userId": 1,
    "message": null
  }
]
```

---

## ❤️ WISHLIST MANAGEMENT

### 1. Add to Wishlist
**POST** `/user/wishlist/{userId}/{productId}` (Auth Required)

**Response (200):**
```json
"Product added to wishlist successfully"
```

### 2. Remove from Wishlist
**DELETE** `/user/wishlist/{userId}/{productId}` (Auth Required)

**Response (200):**
```json
"Product removed from wishlist successfully"
```

### 3. Remove by Wishlist ID
**DELETE** `/user/wishlist/{wishlistId}` (Auth Required)

**Response (200):**
```json
"Wishlist item removed successfully"
```

### 4. Get User Wishlist
**GET** `/user/wishlist/user/{userId}` (Auth Required)

**Response (200):**
```json
[
  {
    "wishlistId": 1,
    "productId": 5,
    "productName": "T-Shirt",
    "productImage": "image_url",
    "productPrice": "25.99"
  }
]
```

---

## 🏪 PRODUCT BROWSING (Public)

### 1. Get All Products
**GET** `/public/getAllProducts` (No Auth Required)

**Response (200):**
```json
[
  {
    "id": 5,
    "productName": "T-Shirt",
    "price": "25.99",
    "originalPrice": "35.99",
    "discount": "28%",
    "quantity": 100,
    "isActive": "true",
    "description": "Comfortable cotton t-shirt",
    "XS": "5",
    "M": "20",
    "L": "30",
    "XL": "25",
    "XXL": "20",
    "imageUrl": "image_url",
    "imagePublicId": "cloudinary_id",
    "category": "Clothing",
    "date": "2024-01-15",
    "time": "10:30",
    "reviews": []
  }
]
```

### 2. Get Products by Category
**GET** `/public/getProductByCategory?category=Clothing` (No Auth Required)
- Returns array of products (same structure as above)

### 3. Get Latest Products
**GET** `/public/getLatestProducts` (No Auth Required)
- Returns array of products (same structure as above)

### 4. Get Product by ID
**GET** `/public/getProductById/{id}` (No Auth Required)
- Returns single product object

---

## 📂 CATEGORIES

### Get All Categories
**GET** `/category/all` (No Auth Required)

**Response (200):**
```json
[
  {
    "id": 1,
    "categoryName": "Clothing"
  },
  {
    "id": 2,
    "categoryName": "Electronics"
  }
]
```

---

## 📊 HTTP STATUS CODES

- **200 OK**: Success with data
- **201 Created**: Resource created
- **204 No Content**: Success without data
- **400 Bad Request**: Invalid request
- **401 Unauthorized**: Authentication required
- **404 Not Found**: Resource not found
- **500 Internal Server Error**: Server error

---

## 📝 USAGE EXAMPLES

### Complete User Flow:

```bash
# 1. Register
curl -X POST https://api.mygarja.com/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"pass123",...}'

# 2. Login  
curl -X POST https://api.mygarja.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"pass123"}'

# 3. Browse Products
curl https://api.mygarja.com/public/getAllProducts

# 4. Add to Cart
curl -X POST https://api.mygarja.com/user/cart/add/5?quantity=2 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# 5. Checkout
curl -X POST https://api.mygarja.com/user/orders/checkout?addressId=1 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Error Handling:
- Always check HTTP status codes
- Handle 401 errors by refreshing/re-authenticating
- Validate request data before sending
- Implement retry logic for 500 errors

---

This documentation covers all user-side endpoints with complete request/response examples for the GARJA e-commerce application.