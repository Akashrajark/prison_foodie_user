import 'package:flutter/material.dart';
import 'package:prison_foodie_user/features/history/history_screen.dart';
import 'package:prison_foodie_user/features/home/home_screen.dart';
import 'package:prison_foodie_user/features/orders/order_screen.dart';
import 'package:prison_foodie_user/features/profile/profile_screen.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

import '../cart/cart_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedindex = 0;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Prison Foodie"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: Icon(
              Icons.shopping_cart,
              color: secondaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(child: pages[selectedindex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        fixedColor: onprimaryColor,
        onTap: onItemTapped,
        currentIndex: selectedindex,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.delivery_dining,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
