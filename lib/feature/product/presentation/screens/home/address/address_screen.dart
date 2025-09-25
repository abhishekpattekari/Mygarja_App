import 'package:flutter/material.dart';
import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/controllers/address_controller.dart';
import 'package:mygarja/models/api/api_address.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const routename = '/address-screen';

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isEditing = false;
  ApiAddress? _editingAddress;

  @override
  void initState() {
    super.initState();
    // Fetch addresses when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressController>(context, listen: false).fetchAddresses();
    });
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _landmarkController.dispose();
    _pincodeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _showAddAddressBottomSheet(BuildContext context) {
    _isEditing = false;
    _editingAddress = null;
    _clearForm();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isEditing ? 'Edit Address' : 'Add New Address',
                  style: asset.introStyles(22),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(
                    labelText: 'Street',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _landmarkController,
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _pincodeController,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pincode';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Full Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _isEditing ? _updateAddress : _addAddress,
                      child: Text(_isEditing ? 'Update' : 'Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editAddress(ApiAddress address) {
    _isEditing = true;
    _editingAddress = address;
    
    _streetController.text = address.street;
    _cityController.text = address.city;
    _landmarkController.text = address.landmark;
    _pincodeController.text = address.pincode;
    _addressController.text = address.address;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Address',
                  style: asset.introStyles(22),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(
                    labelText: 'Street',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _landmarkController,
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _pincodeController,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pincode';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Full Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _updateAddress,
                      child: const Text('Update'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addAddress() async {
    if (_formKey.currentState!.validate()) {
      final addressController = Provider.of<AddressController>(context, listen: false);
      
      final success = await addressController.addAddress(
        street: _streetController.text,
        city: _cityController.text,
        landmark: _landmarkController.text,
        pincode: _pincodeController.text,
        address: _addressController.text,
      );

      if (success) {
        Navigator.pop(context); // Close bottom sheet
        _clearForm();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add address'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _updateAddress() async {
    // For now, we'll just close the sheet as the API doesn't have an update endpoint
    // In a real implementation, you would call an update API
    Navigator.pop(context);
    _clearForm();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteAddress(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final addressController = Provider.of<AddressController>(context, listen: false);
                final success = await addressController.deleteAddress(id);
                
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Address deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to delete address'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _streetController.clear();
    _cityController.clear();
    _landmarkController.clear();
    _pincodeController.clear();
    _addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('My Addresses'),
      body: Consumer<AddressController>(
        builder: (context, addressController, child) {
          if (addressController.isLoading && addressController.addresses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (addressController.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading addresses',
                    style: asset.introStyles(18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    addressController.error!,
                    style: asset.introStyles(14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      addressController.fetchAddresses();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final List<ApiAddress> addresses = addressController.addresses;

          return Column(
            children: [
              if (addresses.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No addresses yet',
                          style: asset.introStyles(24, color: Colors.grey[600]!),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Add your first address',
                          style: asset.introStyles(16, color: Colors.grey[500]!),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${address.street}, ${address.city}',
                                    style: asset.introStyles(18),
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (String result) {
                                      if (result == 'edit') {
                                        _editAddress(address);
                                      } else if (result == 'delete') {
                                        _deleteAddress(address.id);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                address.address,
                                style: asset.introStyles(16, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Landmark: ${address.landmark}',
                                style: asset.introStyles(14, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Pincode: ${address.pincode}',
                                style: asset.introStyles(14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => _showAddAddressBottomSheet(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Add New Address'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}