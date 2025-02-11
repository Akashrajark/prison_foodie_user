import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemBuilder: (context, index) => CustomCartCard(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 6,
      ),
    );
  }
}

//TODO: use material and icon
class CustomCartCard extends StatelessWidget {
  const CustomCartCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: secondaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'http://poojascookery.com/wp-content/uploads/2016/02/DSC3432-min.jpg',
              fit: BoxFit.cover,
              height: 140,
              width: 140,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chapati',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              IconButton.outlined(
                                padding: EdgeInsets.all(2),
                                onPressed: () {},
                                icon: Icon(Icons.remove),
                                style: IconButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    side: BorderSide(color: primaryColor)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '0',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                                style: IconButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    side: BorderSide(color: primaryColor)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Rs. 12',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
