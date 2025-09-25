import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  static const String baseUrl = 'https://api.mygarja.com';
  static const String contentType = 'application/json';
  
  String? _token;

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
    
    return await http.get(uri, headers: headers);
  }

  // Handle HTTP POST requests
  Future<http.Response> post(
    String endpoint,
    dynamic body, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    return await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // Handle HTTP PUT requests
  Future<http.Response> put(
    String endpoint,
    dynamic body, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    return await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // Handle HTTP DELETE requests
  Future<http.Response> delete(
    String endpoint, {
    bool authenticated = false,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = getHeaders(authenticated: authenticated);
    
    return await http.delete(uri, headers: headers);
  }
}