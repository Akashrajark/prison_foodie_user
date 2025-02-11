import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/common_widget/custom_alert_dialog.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/common_widget/custom_text_formfield.dart';
import 'package:prison_foodie_user/features/bottom_navBar_screen/bottom_navbar_screen.dart';

import 'package:prison_foodie_user/features/signin/signin_bloc/signin_bloc.dart';

import 'package:prison_foodie_user/features/signup/signup_screen.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';
import 'package:prison_foodie_user/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
            builder: (context) => CustomBottomNavBar(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider(
        create: (context) => SigninBloc(),
        child: BlocConsumer<SigninBloc, SigninState>(
          listener: (context, state) {
            if (state is SigninSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
                (route) => false,
              );
            } else if (state is SigninFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed',
                  description: state.message,
                  primaryButton: 'Ok',
                ),
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
                      key: _formkey,
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
                            'SIGN IN',
                            style: GoogleFonts.poppins(
                              color: onTertiaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // CustomTextfield(
                          //   validator: emailValidator,
                          //   hinttext: 'email',
                          //   controller: _emailController,
                          // ),
                          CustomTextFormField(
                              isLoading: state is SigninLoadingState,
                              labelText: 'email',
                              controller: _emailController,
                              validator: emailValidator),

                          const SizedBox(height: 10),
                          CustomTextFormField(
                              isLoading: state is SigninLoadingState,
                              labelText: 'password',
                              controller: _passwordController,
                              validator: passwordValidator),

                          // CustomTextfield(
                          //   validator: passwordValidator,
                          //   hinttext: 'password',
                          //   controller: _passwordController,
                          // ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  'Create Account | Signup',
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
                              isLoading: state is SigninLoadingState,
                              inverse: true,
                              label: 'LOGIN',
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  BlocProvider.of<SigninBloc>(context).add(
                                    SigninEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
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
