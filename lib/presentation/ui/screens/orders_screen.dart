import 'package:flutter/material.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/presentation/ui/widgets/footer.dart';

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
        backgroundColor: AppTheme.brown,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order History',
              style: TextStyle(fontSize: 18, color: AppTheme.white),
            ),
            IconButton(
              icon: const Icon(
                Icons.list_alt,
                color: AppTheme.white,
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
