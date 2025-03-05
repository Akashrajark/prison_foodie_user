import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_button.dart';
import '../../common_widget/custom_image_picker_button.dart';
import '../../common_widget/custom_text_formfield.dart';
import '../../util/permission_handler.dart';
import '../../util/value_validator.dart';
import 'profile_bloc/profile_bloc.dart';

class EditProfile extends StatefulWidget {
  final Map profileDetails;
  const EditProfile({super.key, required this.profileDetails});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProfileBloc _profileBloc = ProfileBloc();
  File? file;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      requestStoragePermission();
    });
    _nameController.text = widget.profileDetails['user_name'];
    _phoneController.text = widget.profileDetails['phone'];
    _emailController.text = widget.profileDetails['email'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _profileBloc,
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  description: state.message,
                  primaryButton: 'Try Again',
                  onPrimaryPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is ProfileSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Image Picker
                    AbsorbPointer(
                      absorbing: true,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CustomImagePickerButton(
                              selectedImage: widget.profileDetails['photo'],
                              height: 150,
                              width: 150,
                              borderRadius: 100,
                              onPick: (pick) {
                                file = pick;
                                setState(() {});
                              },
                            ),
                            if (file != null)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      file = null;
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Name Field
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      isLoading: state is ProfileLoadingState,
                      controller: _nameController,
                      validator: alphabeticWithSpaceValidator,
                      labelText: 'Enter your name',
                    ),
                    const SizedBox(height: 20),

                    // Phone Field
                    Text(
                      'Phone Number',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      isLoading: state is ProfileLoadingState,
                      controller: _phoneController,
                      validator: phoneNumberValidator,
                      labelText: 'Enter your phone number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    // Phone Field
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      isLoading: state is ProfileLoadingState,
                      controller: _emailController,
                      validator: emailValidator,
                      labelText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 40),

                    CustomButton(
                      isLoading: state is ProfileLoadingState,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> details = {
                            'user_name': _nameController.text.trim(),
                            'email': _emailController.text.trim(),
                            'phone': _phoneController.text.trim(),
                          };

                          if (file != null) {
                            details['photo_file'] = file!;
                            details['photo_name'] = file!.path;
                          }
                          BlocProvider.of<ProfileBloc>(context).add(
                            EditProfileEvent(
                              profile: details,
                              profileId: widget.profileDetails['id'],
                            ),
                          );
                        }
                      },
                      label: 'Save Changes',
                      iconData: Icons.save,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
