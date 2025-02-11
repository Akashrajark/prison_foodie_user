import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/common_widget/custom_alert_dialog.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/common_widget/custom_text_formfield.dart';
import 'package:prison_foodie_user/features/bottom_navBar_screen/bottom_navbar_screen.dart';
import 'package:prison_foodie_user/features/signin/signin_screen.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';
import 'package:prison_foodie_user/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'sign_up_bloc/sign_up_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _uesrnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      User? currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const CustomBottomNavBar(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailureState) {
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
            } else if (state is SignUpSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Positioned(
                  top: -40,
                  right: -40,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 8),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: -40,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 8),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: CircleAvatar(
                              radius: 56,
                              backgroundColor: primaryColor,
                              child: CircleAvatar(
                                radius: 46,
                                backgroundColor: secondaryColor,
                                child: CircleAvatar(
                                  radius: 43,
                                  backgroundColor: primaryColor,
                                  child: Icon(
                                    Icons.restaurant,
                                    color: secondaryColor,
                                    size: 63,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'SIGNUP',
                            style: GoogleFonts.poppins(
                              color: onTertiaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // CustomTextfield(
                          //   validator: alphabeticWithSpaceValidator,
                          //   hinttext: 'username',
                          //   controller: _uesrnameController,
                          // ),
                          CustomTextFormField(
                              isLoading: state is SignUpLoadingState,
                              labelText: 'username',
                              controller: _uesrnameController,
                              validator: alphabeticWithSpaceValidator),

                          const SizedBox(height: 10),
                          // CustomTextfield(
                          //   validator: emailValidator,
                          //   hinttext: 'email',
                          //   controller: _emailController,
                          // ),
                          CustomTextFormField(
                              isLoading: state is SignUpLoadingState,
                              labelText: 'email',
                              controller: _emailController,
                              validator: emailValidator),

                          const SizedBox(height: 10),
                          // CustomTextfield(
                          //   validator: passwordValidator,
                          //   hinttext: 'password',
                          //   controller: _passwordController,
                          // ),
                          CustomTextFormField(
                              isLoading: state is SignUpLoadingState,
                              labelText: 'password',
                              controller: _passwordController,
                              validator: passwordValidator),

                          const SizedBox(height: 10),
                          // CustomTextfield(
                          //   validator: phoneNumberValidator,
                          //   hinttext: 'phone no.',
                          //   controller: _phoneNoController,
                          // ),
                          CustomTextFormField(
                              isLoading: state is SignUpLoadingState,
                              labelText: 'phone no.',
                              controller: _phoneNoController,
                              validator: phoneNumberValidator),

                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  'Already Account | Login',
                                  style: GoogleFonts.poppins(
                                    color: onTertiaryColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomButton(
                              isLoading: state is SignUpLoadingState,
                              inverse: true,
                              label: 'SIGNUP',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpUserEvent(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        userDetails: {
                                          'email': _emailController.text.trim(),
                                          'phone':
                                              _phoneNoController.text.trim(),
                                        }),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
