import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/application/bloc/cart/cart_bloc.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/presentation/ui/widgets/footer.dart';
import 'package:myapp/presentation/ui/screens/detail_screen.dart';

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
        backgroundColor: AppTheme.brown,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Cart',
              style: TextStyle(fontSize: 18, color: AppTheme.white),
            ),
            IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: AppTheme.white,
                ),
                onPressed: () {})
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            final cartItems = state.cartItems;
            if (cartItems.isEmpty) {
              return const Center(
                child: Text('No items in cart!'),
              );
            } else {
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(coffeeItem: item)),
                        );
                      },
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(item.name,
                            style: TextStyle(
                                color: Theme.of(context).highlightColor)),
                        subtitle: Text('\$ ${item.price.toString()}',
                            style: TextStyle(
                                color: Theme.of(context).highlightColor)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,
                              color: AppTheme.red, size: 18),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                              RemoveItemFromCart(item),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text('No items in cart!'),
            );
          }
        },
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 3,
      ),
    );
  }
}
