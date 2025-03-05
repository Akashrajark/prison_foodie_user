import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/util/get_lat_lng.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widget/custom_text_formfield.dart';
import '../../util/value_validator.dart';
import 'address_bloc/address_bloc.dart';

class AddEditAddressScreen extends StatefulWidget {
  final Map? addressDetails;
  final int? addressId;

  const AddEditAddressScreen({
    super.key,
    this.addressDetails,
    this.addressId,
  });

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    if (widget.addressDetails != null) {
      _titleController.text = widget.addressDetails!['title'];
      _stateController.text = widget.addressDetails!['state'];
      _districtController.text = widget.addressDetails!['district'];
      _placeController.text = widget.addressDetails!['place'];
      _pincodeController.text = widget.addressDetails!['pincode'];
      _addressLineController.text = widget.addressDetails!['address_line'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shrinkWrap: true,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2D2D2D),
                      ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  isLoading: state is AddressLoadingState,
                  labelText: 'Enter Title',
                  controller: _titleController,
                  validator: alphabeticWithSpaceValidator,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'state',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2D2D2D),
                      ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  isLoading: state is AddressLoadingState,
                  labelText: 'Enter State',
                  controller: _stateController,
                  validator: alphabeticWithSpaceValidator,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'District',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2D2D2D),
                      ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  isLoading: state is AddressLoadingState,
                  labelText: 'Enter District',
                  controller: _districtController,
                  validator: alphabeticWithSpaceValidator,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Place',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2D2D2D),
                      ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  isLoading: state is AddressLoadingState,
                  labelText: 'Enter Place',
                  controller: _placeController,
                  validator: alphabeticWithSpaceValidator,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Address Line',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2D2D2D),
                      ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  isLoading: state is AddressLoadingState,
                  labelText: 'Enter Address',
                  controller: _addressLineController,
                  validator: alphabeticWithSpaceValidator,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Pincode',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF2D2D2D),
                      ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  isLoading: state is AddressLoadingState,
                  labelText: 'Enter Pincode',
                  controller: _pincodeController,
                  validator: pincodeValidator,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  inverse: true,
                  isLoading: _isLoading,
                  label: 'Save',
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _isLoading = true;
                    setState(() {});

                    LatLng? latlng = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetLatLng(),
                      ),
                    );

                    try {
                      if (latlng != null) {
                        await Supabase.instance.client.from('address').insert({
                          'title': _titleController.text,
                          'user_id':
                              Supabase.instance.client.auth.currentUser!.id,
                          'state': _stateController.text,
                          'latitude': latlng.latitude,
                          'longitude': latlng.longitude,
                          'district': _districtController.text,
                          'place': _placeController.text,
                          'address_line': _addressLineController.text,
                          'pincode': _pincodeController.text,
                        });

                        Navigator.pop(context);
                      }
                    } catch (e, s) {
                      print(e.toString());
                      print(s.toString());
                    }

                    _isLoading = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
