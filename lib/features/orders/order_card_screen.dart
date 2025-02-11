import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/features/orders/order_details_screen.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class OrderCardScreen extends StatelessWidget {
  final String status;
  final Color statusColor;

  const OrderCardScreen({
    super.key,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
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
                color: statusColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    status,
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsScreen(
                    status: status,
                    statusColor: statusColor,
                  ),
                ),
              );
            },
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: onSurfaceColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order details',
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
