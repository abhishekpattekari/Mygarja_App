import 'package:flutter/material.dart';
import '../models/api/api_address.dart';
import '../services/address_service.dart';

class AddressController extends ChangeNotifier {
  List<ApiAddress> _addresses = [];
  bool _isLoading = false;
  final AddressService _addressService = AddressService();

  List<ApiAddress> get addresses => _addresses;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;

  // Alias for getUserAddresses to match expected method name
  Future<void> fetchAddresses() async {
    await getUserAddresses();
  }

  // Add address
  Future<bool> addAddress({
    required String street,
    required String city,
    required String landmark,
    required String pincode,
    required String address,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final ApiAddress? newAddress = await _addressService.addAddress(
        street: street,
        city: city,
        landmark: landmark,
        pincode: pincode,
        address: address,
      );
      
      if (newAddress != null) {
        _addresses.add(newAddress);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('AddressController: Failed to add address - possibly authentication issue');
        _error = 'Failed to add address - authentication may be required';
      }
    } catch (e) {
      print('AddressController: Add address error: $e');
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Get user addresses
  Future<void> getUserAddresses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final List<ApiAddress>? addresses = await _addressService.getUserAddresses();
      if (addresses != null) {
        _addresses = addresses;
      } else {
        // Handle error - possibly authentication issue
        print('AddressController: Failed to get user addresses - possibly authentication issue');
        _error = 'Failed to load addresses - authentication may be required';
      }
    } catch (e) {
      print('AddressController: Get user addresses error: $e');
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete address
  Future<bool> deleteAddress(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final bool success = await _addressService.deleteAddress(id);
      if (success) {
        _addresses.removeWhere((address) => address.id == id);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Handle error - possibly authentication issue
        print('AddressController: Failed to delete address - possibly authentication issue');
        _error = 'Failed to delete address - authentication may be required';
      }
    } catch (e) {
      print('AddressController: Delete address error: $e');
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}