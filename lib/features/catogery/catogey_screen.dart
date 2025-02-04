import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/features/home/menu_item_card.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class CatogeyScreen extends StatelessWidget {
  const CatogeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catogery type',
          style: GoogleFonts.poppins(
            color: onTertiaryColor,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => const MenuItemCard(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 5,
        ),
      ),
    );
  }
}
