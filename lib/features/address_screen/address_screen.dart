import 'package:flutter/material.dart';

class Address {
  final int id;
  final String address;
  final String pincode;

  Address({
    required this.id,
    required this.address,
    required this.pincode,
  });
}

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Address> addresses = [];
  int? selectedAddressId;
  int _nextId = 0;

  void _showAddAddressDialog() {
    final formKey = GlobalKey<FormState>();
    String newAddress = '';
    String newPincode = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Address',
                  hintText: 'Enter your complete address',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (value) => newAddress = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pincode',
                  hintText: 'Enter 6-digit pincode',
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pincode';
                  }
                  if (value.length != 6) {
                    return 'Pincode must be 6 digits';
                  }
                  return null;
                },
                onSaved: (value) => newPincode = value!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                setState(() {
                  addresses.add(Address(
                    id: _nextId,
                    address: newAddress,
                    pincode: newPincode,
                  ));
                  selectedAddressId = _nextId;
                  _nextId++;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteAddress(int id) {
    setState(() {
      addresses.removeWhere((address) => address.id == id);
      if (selectedAddressId == id) {
        selectedAddressId = addresses.isNotEmpty ? addresses.first.id : null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Addresses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return Card(
                    child: ListTile(
                      leading: Radio<int>(
                        value: address.id,
                        groupValue: selectedAddressId,
                        onChanged: (value) {
                          setState(() {
                            selectedAddressId = value;
                          });
                        },
                      ),
                      title: Text(address.address),
                      subtitle: Text('Pincode: ${address.pincode}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteAddress(address.id),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_location_alt),
              label: const Text('Add New Address'),
              onPressed: _showAddAddressDialog,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
