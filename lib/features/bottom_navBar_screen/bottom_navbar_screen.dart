import 'package:flutter/material.dart';
import 'package:prison_foodie_user/features/history/history_screen.dart';
import 'package:prison_foodie_user/features/home/home_screen.dart';
import 'package:prison_foodie_user/features/orders/order_screen.dart';
import 'package:prison_foodie_user/features/profile/profile_screen.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

int selectedindex = 0;

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List pages = [
    const HomeScreen(),
    const OrderScreen(),
    const HistoryScreen(),
    const ProfileScreen()
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedindex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: onprimaryColor,
          fixedColor: onSecondaryColor,
          onTap: onItemTapped,
          currentIndex: selectedindex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.delivery_dining,
                  size: 30,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: 30,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
                label: '')
          ],
        ),
      ),
    );
  }
}
