import 'package:flutter/material.dart';
import 'package:prison_foodie_user/features/orders/order_card_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => const OrderCardScreen(
                status: 'Delivered',
                statusColor: Colors.lightGreenAccent,
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
