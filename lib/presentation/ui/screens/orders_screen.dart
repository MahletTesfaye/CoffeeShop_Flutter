import 'package:flutter/material.dart';
import 'package:myapp/presentation/widgets/footer.dart';

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
        backgroundColor: Colors.brown,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order History',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            IconButton(
              icon: const Icon(
                Icons.list_alt,
                color: Colors.white,
              ),
              onPressed: () {},
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
