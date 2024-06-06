import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/utils/footer.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  OrdersListState createState() => OrdersListState();
}

class OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: () => context.pop(),
            ),
            const Text(
              'Order History',
              style: TextStyle(fontSize: 18, color: Colors.brown),
            )
          ],
        ),
      ),
      body: const Center(child: Text('No order history')),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 2,
      ),
    );
  }
}
