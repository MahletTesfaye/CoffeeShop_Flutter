import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/application/bloc/cart/cart_bloc.dart';

class PriceActions extends StatelessWidget {
  final double price;
  final bool isInCart;
  final CoffeeItem coffeeItem;

  const PriceActions({
    super.key,
    required this.price,
    required this.isInCart,
    required this.coffeeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Price',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor),
            ),
            const SizedBox(height: 6),
            Text(
              '\$ $price',
              style: TextStyle(color: Theme.of(context).highlightColor),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 130,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              final cartBloc = BlocProvider.of<CartBloc>(context);
              isInCart
                  ? cartBloc.add(RemoveItemFromCart(coffeeItem))
                  : cartBloc.add(AddItemToCart(coffeeItem));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              foregroundColor: AppTheme.white,
            ),
            child: Text(isInCart ? 'Remove' : 'Add to Cart'),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 105,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              context.go('/orders');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Buy Now',
              style: TextStyle(color: AppTheme.white),
            ),
          ),
        ),
      ],
    );
  }
}
