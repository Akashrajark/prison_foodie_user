import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

class MenuItemCard extends StatefulWidget {
  final String image, price, name;

  const MenuItemCard({
    super.key,
    required this.image,
    required this.price,
    required this.name,
  });

  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: secondaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              widget.image,
              fit: BoxFit.cover,
              height: 160,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      inverse: true,
                      label: 'Add',
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            sheetAnimationStyle: AnimationStyle(
                              curve: Curves.easeInBack,
                              duration: const Duration(seconds: 1),
                              reverseDuration:
                                  const Duration(milliseconds: 500),
                            ),
                            builder: (context) => AddItermCountDialog());
                      },
                      iconData: Icons.add_shopping_cart_rounded,
                    ),
                    Text(
                      widget.price,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddItermCountDialog extends StatefulWidget {
  const AddItermCountDialog({
    super.key,
  });

  @override
  State<AddItermCountDialog> createState() => _AddItermCountDialogState();
}

class _AddItermCountDialogState extends State<AddItermCountDialog> {
  int tempCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 16),
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
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
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
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton.outlined(
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
                        textStyle: Theme.of(context).textTheme.titleMedium,
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Rs. 12',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    CustomButton(
                      inverse: true,
                      onPressed: () {},
                      label: 'Add',
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
