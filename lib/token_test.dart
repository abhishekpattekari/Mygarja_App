import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print('Testing token authentication...');
  
  // Replace with a valid token from your app
  final String token = 'YOUR_VALID_TOKEN_HERE';
  
  try {
    // Test the profile endpoint with a valid token
    print('Testing /common/showProfile endpoint...');
    final profileResponse = await http.get(
      Uri.parse('https://api.mygarja.com/common/showProfile'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    print('Profile response status: ${profileResponse.statusCode}');
    print('Profile response body preview: ${profileResponse.body.substring(0, 200)}');
    
    if (profileResponse.body.trim().startsWith('<!doctype') || 
        profileResponse.body.trim().startsWith('<html')) {
      print('ERROR: Received HTML instead of JSON!');
    } else {
      print('SUCCESS: Received JSON response');
    }
    
    // Test the cart endpoint with the same token
    print('\nTesting /user/cart endpoint...');
    final cartResponse = await http.get(
      Uri.parse('https://api.mygarja.com/user/cart'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    print('Cart response status: ${cartResponse.statusCode}');
    print('Cart response body preview: ${cartResponse.body.substring(0, 200)}');
    
    if (cartResponse.body.trim().startsWith('<!doctype') || 
        cartResponse.body.trim().startsWith('<html')) {
      print('ERROR: Received HTML instead of JSON!');
    } else {
      print('SUCCESS: Received JSON response');
    }
  } catch (e) {
    print('Error during token test: $e');
  }
}