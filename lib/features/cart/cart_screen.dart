import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_user/common_widget/custom_button.dart';
import 'package:prison_foodie_user/features/orders/orders_bloc/orders_bloc.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';
import 'carts_bloc/carts_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartsBloc _cartsBloc = CartsBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map<String, dynamic>> _carts = [];

  @override
  void initState() {
    getCarts();
    super.initState();
  }

  void getCarts() {
    _cartsBloc.add(GetAllCartsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(),
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, orderState) {
          if (orderState is OrdersFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: orderState.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getCarts();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (orderState is OrdersSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, orderState) {
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
            body: BlocProvider.value(
              value: _cartsBloc,
              child: BlocConsumer<CartsBloc, CartsState>(
                listener: (context, state) {
                  if (state is CartsFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Failure',
                        description: state.message,
                        primaryButton: 'Try Again',
                        onPrimaryPressed: () {
                          getCarts();
                          Navigator.pop(context);
                        },
                      ),
                    );
                  } else if (state is CartsGetSuccessState) {
                    _carts = state.carts;
                    Logger().w(_carts);
                    setState(() {});
                  } else if (state is CartsSuccessState) {
                    getCarts();
                  }
                },
                builder: (context, state) {
                  if (state is CartsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CartsGetSuccessState && _carts.isEmpty) {
                    return Center(
                      child: Text(
                        'No Cart Item Found!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CustomCartCard(
                      cartDetails: _carts[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: _carts.length,
                  );
                },
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rs. ${getTotalPrice().toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    inverse: true,
                    onPressed: () {
                      BlocProvider.of<OrdersBloc>(context)
                          .add(AddOrderEvent(orderDetails: {}));
                    },
                    label: 'Order Now',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  double getTotalPrice() {
    return _carts.fold(0.0, (sum, item) {
      final price = item['food_items']['price'] is num
          ? item['food_items']['price'].toDouble()
          : double.tryParse(item['food_items']['price'].toString()) ?? 0.0;
      final count = item['count'] is int ? item['count'] : 1;
      return sum + (price * count);
    });
  }
}

//TODO: use material and icon
class CustomCartCard extends StatefulWidget {
  final Map<String, dynamic> cartDetails;
  const CustomCartCard({
    super.key,
    required this.cartDetails,
  });

  @override
  State<CustomCartCard> createState() => _CustomCartCardState();
}

class _CustomCartCardState extends State<CustomCartCard> {
  Map<String, dynamic> cartdetails = {};

  @override
  void initState() {
    cartdetails['count'] = widget.cartDetails['count'];
    cartdetails['id'] = widget.cartDetails['id'];
    cartdetails['food_item_id'] = widget.cartDetails['food_item_id'];
    cartdetails['user_id'] = widget.cartDetails['user_id'];
    super.initState();
  }

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
              widget.cartDetails['food_items']['image_url'],
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
                        widget.cartDetails['food_items']['name'],
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<CartsBloc>(context)
                              .add(DeleteCartEvent(cartId: cartdetails['id']));
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
                                onPressed: cartdetails['count'] > 1
                                    ? () {
                                        cartdetails['count'] =
                                            cartdetails['count'] - 1;

                                        BlocProvider.of<CartsBloc>(context).add(
                                            EditCartEvent(
                                                cartDetails: cartdetails,
                                                cartId: cartdetails['id']));
                                      }
                                    : null, // Disable button if count is 1
                                icon: Icon(Icons.remove),
                                style: IconButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    side: BorderSide(color: primaryColor)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                cartdetails['count'].toString(),
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                onPressed: () {
                                  cartdetails['count'] =
                                      cartdetails['count'] + 1;

                                  BlocProvider.of<CartsBloc>(context).add(
                                      EditCartEvent(
                                          cartDetails: cartdetails,
                                          cartId: cartdetails['id']));
                                },
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
                        'Rs. ${widget.cartDetails['food_items']['price']}',
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
