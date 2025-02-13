import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/features/cart/carts_bloc/carts_bloc.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuItemCard extends StatefulWidget {
  final Map menuDetails;

  const MenuItemCard({
    super.key,
    required this.menuDetails,
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
              widget.menuDetails['image_url'],
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
                  widget.menuDetails['name'],
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
                            builder: (context) => AddItemCountModalBottomsheet(
                                  menuDetails: widget.menuDetails,
                                ));
                      },
                      iconData: Icons.add_shopping_cart_rounded,
                    ),
                    Text(
                      widget.menuDetails['price'].toString(),
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

class AddItemCountModalBottomsheet extends StatefulWidget {
  final Map menuDetails;
  const AddItemCountModalBottomsheet({
    super.key,
    required this.menuDetails,
  });

  @override
  State<AddItemCountModalBottomsheet> createState() =>
      _AddItemCountModalBottomsheetState();
}

class _AddItemCountModalBottomsheetState
    extends State<AddItemCountModalBottomsheet> {
  int tempCounter = 0;

  void _incrementCounter() {
    setState(() {
      tempCounter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (tempCounter > 0) {
        tempCounter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartsBloc(),
      child: BlocConsumer<CartsBloc, CartsState>(
        listener: (context, state) {
          if (state is CartsSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.menuDetails['image_url'],
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
                            widget.menuDetails['name'],
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
                            onPressed: _decrementCounter,
                            icon: Icon(Icons.remove),
                            style: IconButton.styleFrom(
                                foregroundColor: primaryColor,
                                side: BorderSide(color: primaryColor)),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$tempCounter',
                            style: GoogleFonts.poppins(
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton.outlined(
                            onPressed: _incrementCounter,
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
                              widget.menuDetails['price'].toString(),
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          CustomButton(
                            inverse: true,
                            onPressed: () {
                              if (tempCounter > 0) {
                                BlocProvider.of<CartsBloc>(context)
                                    .add(AddCartEvent(
                                  cartDetails: {
                                    'p_user_id': Supabase
                                        .instance.client.auth.currentUser!.id,
                                    'p_food_item_id': widget.menuDetails['id'],
                                    'p_count': tempCounter,
                                  },
                                ));
                              } //TODO:else
                            },
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
        },
      ),
    );
  }
}
