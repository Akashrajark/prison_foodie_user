import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatogeryCard extends StatelessWidget {
  final String label;
  final String image;
  final Function() onTap;
  const CatogeryCard({
    super.key,
    required this.label,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
