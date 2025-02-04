import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/common_widgets/custom_button.dart';
import 'package:prison_foodie_user/common_widgets/custom_textfield.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: onprimaryColor, width: 8),
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
                border: Border.all(color: onprimaryColor, width: 8),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: onprimaryColor,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: onSecondaryColor,
                        child: CircleAvatar(
                          radius: 43,
                          backgroundColor: onprimaryColor,
                          child: Icon(
                            Icons.restaurant,
                            color: onSecondaryColor,
                            size: 63,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'LOGIN',
                    style: GoogleFonts.poppins(
                      color: onTertiaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CustomTextfield(hinttext: 'email'),
                  const SizedBox(height: 10),
                  const CustomTextfield(hinttext: 'password'),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
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
                      label: 'LOGIN',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
