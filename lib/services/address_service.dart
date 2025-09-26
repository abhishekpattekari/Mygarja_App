import 'api_service.dart';
import '../models/api/api_address.dart';
import 'dart:convert';

class AddressService extends ApiService {
  // Add Address
  Future<ApiAddress?> addAddress({
    required String street,
    required String city,
    required String landmark,
    required String pincode,
    required String address,
  }) async {
    try {
      final response = await post('/user/address/add', {
        'steet': street,
        'city': city,
        'landmark': landmark,
        'pincode': pincode,
        'address': address,
      }, authenticated: true);

      if (response.statusCode == 200) {
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final jsonData = jsonDecode(response.body);
          return ApiAddress.fromJson(jsonData);
        } else {
          print('Add address failed: Response is not valid JSON');
          print('Response status: ${response.statusCode}');
          print('Response content: ${response.body.substring(0, 500)}');
          
          // Check if this is an authentication issue
          if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
            print('Add address failed: Authentication error - token may be invalid or expired');
          }
          
          return null;
        }
      } else {
        print('Add address failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        return null;
      }
    } catch (e) {
      print('Add address error: $e');
      return null;
    }
  }

  // Get User Addresses
  Future<List<ApiAddress>?> getUserAddresses() async {
    try {
      final response = await get('/user/address/byUser', authenticated: true);

      if (response.statusCode == 200) {
        // Check if response is valid JSON
        if (isValidJson(response.body)) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          final List<ApiAddress> addresses = jsonData
              .map((item) => ApiAddress.fromJson(item as Map<String, dynamic>))
              .toList();
          return addresses;
        } else {
          print('Get user addresses failed: Response is not valid JSON');
          print('Response status: ${response.statusCode}');
          print('Response content: ${response.body.substring(0, 500)}');
          
          // Check if this is an authentication issue
          if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
            print('Get user addresses failed: Authentication error - token may be invalid or expired');
          }
          
          return null;
        }
      } else {
        print('Get user addresses failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        return null;
      }
    } catch (e) {
      print('Get user addresses error: $e');
      return null;
    }
  }

  // Delete Address
  Future<bool> deleteAddress(int id) async {
    try {
      final response = await delete('/user/address/$id', authenticated: true);

      if (response.statusCode == 204) {
        return true;
      } else {
        print('Delete address failed with status: ${response.statusCode}');
        print('Response content: ${response.body.substring(0, 500)}');
        
        // Check if this is an authentication issue
        if (response.body.trim().startsWith('<!doctype') || response.body.trim().startsWith('<html')) {
          print('Delete address failed: Authentication error - token may be invalid or expired');
        }
        
        return false;
      }
    } catch (e) {
      print('Delete address error: $e');
      return false;
    }
  }
}