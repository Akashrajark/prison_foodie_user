import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/features/address_screen/address_screen.dart';
import 'package:prison_foodie_user/features/profile/profile_edit_page.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.poppins(
              color: onTertiaryColor,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
            ),
            title: Text(
              'Kochappi',
              style: GoogleFonts.poppins(
                color: onTertiaryColor,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: Text(
              'Kochappi@gmail.com',
              style: GoogleFonts.poppins(
                color: onTertiaryColor,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              inverse: true,
              label: 'Edit',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileEditPage(),
                    ));
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressScreen(),
                  ));
            },
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Address',
                      style: GoogleFonts.poppins(
                        color: onTertiaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_right_outlined)
                ],
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
