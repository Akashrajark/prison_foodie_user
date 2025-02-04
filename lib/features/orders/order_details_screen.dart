import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/features/home/menu_item_card.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String status;
  final Color statusColor;

  const OrderDetailsScreen({
    super.key,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Order Details',
          style: GoogleFonts.poppins(
            color: onTertiaryColor,
            fontSize: 13,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '16/02/2004 \n06:25',
                      style: GoogleFonts.poppins(
                        color: onTertiaryColor,
                        fontSize: 13,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: statusColor, // Dynamic status color
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          status, // Dynamic status text
                          style: GoogleFonts.poppins(
                            color: onTertiaryColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '#5326427444',
                  style: GoogleFonts.poppins(
                    color: onTertiaryColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'COD',
                      style: GoogleFonts.poppins(
                        color: onTertiaryColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'PRICE : 2344',
                      style: GoogleFonts.poppins(
                        color: onTertiaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  'Your Delivery Partner',
                  style: GoogleFonts.poppins(
                    color: onTertiaryColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const CircleAvatar(radius: 30),
                    const SizedBox(width: 15),
                    Text(
                      'Chakochi',
                      style: GoogleFonts.poppins(
                        color: onTertiaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  'Your Order Details',
                  style: GoogleFonts.poppins(
                    color: onTertiaryColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => const MenuItemCard(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
