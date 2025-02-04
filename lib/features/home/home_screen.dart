import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/features/cart/cart_screen.dart';
import 'package:prison_foodie_user/features/catogery/catogey_screen.dart';
import 'package:prison_foodie_user/features/home/catogery_card.dart';
import 'package:prison_foodie_user/features/home/menu_item_card.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Categories',
                style: GoogleFonts.poppins(
                  color: onTertiaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: onprimaryColor,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: onSecondaryColor,
                      ),
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatogeyScreen(),
                      ));
                },
                child: const CatogeryCard(
                    label: 'Curry',
                    imgUrl:
                        'http://poojascookery.com/wp-content/uploads/2016/02/DSC3432-min.jpg'),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: 4,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Today’s Menu',
            style: GoogleFonts.poppins(
              color: onTertiaryColor,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Flexible(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => MenuItemCard(
                onAdd: () {},
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 5,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
