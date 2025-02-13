import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';

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
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.addressDetails != null) {
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
                  label: 'Save',
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
