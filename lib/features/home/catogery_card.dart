import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class CatogeryCard extends StatelessWidget {
  final String label;
  final String imgUrl;
  const CatogeryCard({super.key, required this.label, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(label,
            style: GoogleFonts.poppins(
              color: onSurfaceColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }
}
