import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/features/home/menu_item_card.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Cart Screen',
          style: GoogleFonts.poppins(
            color: onTertiaryColor,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => const MenuItemCard(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
