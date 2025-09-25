import 'package:flutter/material.dart';
import '../services/address_service.dart';
import '../models/api/api_address.dart';

class AddressController extends ChangeNotifier {
  List<ApiAddress> _addresses = [];
  bool _isLoading = false;
  String? _error;
  final AddressService _addressService = AddressService();

  List<ApiAddress> get addresses => _addresses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all user addresses
  Future<void> fetchAddresses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final List<ApiAddress>? addresses = await _addressService.getUserAddresses();
      if (addresses != null) {
        _addresses = addresses;
      }
    } catch (e) {
      _error = 'Failed to load addresses: $e';
      print('Address fetch error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new address
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
      }
    } catch (e) {
      _error = 'Failed to add address: $e';
      print('Address add error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  // Delete an address
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
      }
    } catch (e) {
      _error = 'Failed to delete address: $e';
      print('Address delete error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}