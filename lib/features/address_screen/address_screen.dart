import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_user/features/address_screen/add_edit_address_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widget/custom_alert_dialog.dart';
import 'address_bloc/address_bloc.dart';

class AddressScreen extends StatefulWidget {
  final bool pickMode;
  const AddressScreen({super.key, this.pickMode = false});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressBloc _addressBloc = AddressBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map<String, dynamic>> _address = [];

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  void getAddress() {
    _addressBloc.add(GetAllAddressEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _addressBloc,
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getAddress();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is AddressGetSuccessState) {
            _address = state.address;
            Logger().w(_address);
            setState(() {});
          } else if (state is AddressSuccessState) {
            getAddress();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Addresses'),
            ),
            body: state is AddressGetSuccessState
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _address.length,
                    itemBuilder: (context, index) {
                      return AddressCard(
                        address: _address[index],
                        onTap: () {
                          Navigator.pop(context, _address[index]['id']);
                        },
                        onDelete: () async {
                          await Supabase.instance.client
                              .from('address')
                              .delete()
                              .eq('id', _address[index]['id']);

                          _addressBloc.add(GetAllAddressEvent(params: params));
                        },
                      );
                    },
                  )
                : Center(child: const CupertinoActivityIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: _addressBloc,
                      child: AddEditAddressScreen(),
                    ),
                  ),
                );

                _addressBloc.add(GetAllAddressEvent(params: params));
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final Map<String, dynamic> address;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool pickMode;

  const AddressCard({
    super.key,
    required this.address,
    required this.onTap,
    required this.onDelete,
    this.pickMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: address['isSelected'] ?? false
              ? Theme.of(context).primaryColor
              : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    address['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!pickMode)
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: onDelete,
                    ),
                ],
              ),
              const Divider(height: 20),
              const SizedBox(height: 8),
              Text(
                '📍 ${address['address_line']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '🏙️ ${address['place']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '🏘️ ${address['district']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '🌆 ${address['state']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '📌 Pincode: ${address['pincode']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
