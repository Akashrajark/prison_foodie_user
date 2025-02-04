import 'package:flutter/material.dart';
import 'package:prison_foodie_user/features/bottom_navBar_screen/bottom_navbar_screen.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const CustomBottomNavBar(),
    );
  }
}
