import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  static const String baseUrl = 'https://api.mygarja.com';
  static const String contentType = 'application/json';
  
  String? _token;

  // Get the authentication token
  String? get token => _token;

  // Set the authentication token
  void setToken(String token) {
    _token = token;
  }

  // Clear the authentication token
  void clearToken() {
    _token = null;
  }

  // Get headers with optional authentication
  Map<String, String> getHeaders({bool authenticated = false}) {
    final headers = {
      'Content-Type': contentType,
      'Accept': contentType,
    };

    if (authenticated && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  // Handle HTTP GET requests
  Future<http.Response> get(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    print('ApiService: GET $uri with headers: $headers');
    
    final response = await http.get(uri, headers: headers);
    
    print('ApiService: GET response status: ${response.statusCode}');
    print('ApiService: GET response body: ${response.body.substring(0, min(response.body.length, 500))}');
    
    // Check if response is HTML (error page) and log it
    if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
      print('ApiService: WARNING - Received HTML response instead of JSON!');
      print('ApiService: This usually indicates an authentication issue or server error');
      
      // If this is an authenticated request, the token might be invalid
      if (authenticated) {
        print('ApiService: Authenticated request failed - token may be invalid or expired');
      }
    }
    
    return response;
  }

  // Handle HTTP POST requests
  Future<http.Response> post(
    String endpoint,
    dynamic body, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    print('ApiService: POST $uri with headers: $headers and body: $body');
    
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    
    print('ApiService: POST response status: ${response.statusCode}');
    print('ApiService: POST response body: ${response.body.substring(0, min(response.body.length, 500))}');
    
    // Check if response is HTML (error page) and log it
    if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
      print('ApiService: WARNING - Received HTML response instead of JSON!');
      print('ApiService: This usually indicates an authentication issue or server error');
      
      // If this is an authenticated request, the token might be invalid
      if (authenticated) {
        print('ApiService: Authenticated request failed - token may be invalid or expired');
      }
    }
    
    return response;
  }

  // Handle HTTP PUT requests
  Future<http.Response> put(
    String endpoint,
    dynamic body, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    print('ApiService: PUT $uri with headers: $headers and body: $body');
    
    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    
    print('ApiService: PUT response status: ${response.statusCode}');
    print('ApiService: PUT response body: ${response.body.substring(0, min(response.body.length, 500))}');
    
    // Check if response is HTML (error page) and log it
    if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
      print('ApiService: WARNING - Received HTML response instead of JSON!');
      print('ApiService: This usually indicates an authentication issue or server error');
      
      // If this is an authenticated request, the token might be invalid
      if (authenticated) {
        print('ApiService: Authenticated request failed - token may be invalid or expired');
      }
    }
    
    return response;
  }

  // Handle HTTP DELETE requests
  Future<http.Response> delete(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    print('ApiService: DELETE $uri with headers: $headers');
    
    final response = await http.delete(uri, headers: headers);
    
    print('ApiService: DELETE response status: ${response.statusCode}');
    print('ApiService: DELETE response body: ${response.body.substring(0, min(response.body.length, 500))}');
    
    // Check if response is HTML (error page) and log it
    if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
      print('ApiService: WARNING - Received HTML response instead of JSON!');
      print('ApiService: This usually indicates an authentication issue or server error');
      
      // If this is an authenticated request, the token might be invalid
      if (authenticated) {
        print('ApiService: Authenticated request failed - token may be invalid or expired');
      }
    }
    
    return response;
  }
  
  // Helper method to check if response is valid JSON
  bool isValidJson(String response) {
    // Also check if response is HTML (error page)
    if (response.trim().startsWith('<!doctype') || response.trim().startsWith('<html')) {
      return false;
    }
    
    try {
      jsonDecode(response);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Helper method to get min of two integers
  int min(int a, int b) => a < b ? a : b;
}