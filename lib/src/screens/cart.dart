import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/utils/footer.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  AddToCartState createState() => AddToCartState();
}

class AddToCartState extends State<AddToCart> {
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
              'Your Cart',
              style: TextStyle(fontSize: 18, color: Colors.brown),
            )
          ],
        ),
      ),
      body: const Center(child: Text('No items in your cart yet')),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 3,
      ),
    );
  }
}
