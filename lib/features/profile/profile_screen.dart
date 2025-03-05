import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/features/address_screen/address_screen.dart';
import 'package:prison_foodie_user/features/profile/profile_edit_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import '../signin/signin_screen.dart';
import 'profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();

  Map _profile = {};

  @override
  void initState() {
    getProfile();
    checkLogin(context);
    super.initState();
  }

  void getProfile() {
    _profileBloc.add(GetAllProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>.value(
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
                  getProfile();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is ProfileGetSuccessState) {
            _profile = state.profile;
            Logger().w(_profile);
            setState(() {});
          } else if (state is ProfileSuccessState) {
            getProfile();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  if (_profile['photo'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        _profile['photo'],
                        height: 100,
                        width: 100,
                      ),
                    ),
                  if (_profile['photo'] == null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.grey,
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    _profile['user_name'] ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text('Phone'),
                          subtitle: Text(_profile['phone'] ?? ''),
                          onTap: () {/* Add phone action */},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(_profile['email'] ?? ''),
                          onTap: () {/* Add email action */},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          // Navigate to edit profile
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressScreen()),
                          );
                        },
                        label: 'Address',
                        iconData: Icons.edit,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onPressed: () {
                          // Navigate to edit profile
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                profileDetails: _profile,
                              ),
                            ),
                          );
                        },
                        label: 'Edit Profile',
                        iconData: Icons.edit,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: "Sign Out",
                              content: const Text(
                                "Are you sure you want to Sign Out? Clicking 'Sign Out' will end your current session and require you to sign in again to access your account.",
                              ),
                              primaryButton: "Sign Out",
                              onPrimaryPressed: () {
                                Supabase.instance.client.auth.signOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          );
                        },
                        label: 'Sign Out',
                        iconData: Icons.logout_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
