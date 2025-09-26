import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print('Testing API connection...');
  
  try {
    // Test the public products endpoint first (no auth required)
    print('Testing public products endpoint...');
    final productsResponse = await http.get(
      Uri.parse('https://api.mygarja.com/public/getAllProducts'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    
    print('Products response status: ${productsResponse.statusCode}');
    print('Products response body preview: ${productsResponse.body.substring(0, 200)}');
    
    if (productsResponse.body.trim().startsWith('<!doctype') || 
        productsResponse.body.trim().startsWith('<html')) {
      print('ERROR: Received HTML instead of JSON!');
      print('Full HTML response:');
      print(productsResponse.body);
    } else {
      print('SUCCESS: Received JSON response');
      // Try to parse as JSON
      try {
        final jsonData = jsonDecode(productsResponse.body);
        print('Parsed JSON successfully. Data type: ${jsonData.runtimeType}');
      } catch (e) {
        print('Failed to parse JSON: $e');
      }
    }
  } catch (e) {
    print('Error during API test: $e');
  }
}