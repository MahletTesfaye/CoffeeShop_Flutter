import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/bloc/CartItems/cart_bloc.dart';
import 'package:myapp/src/models/coffee_model.dart';

class DetailPage extends StatefulWidget {
  final CoffeeItem coffeeItem;
  const DetailPage({super.key, required this.coffeeItem});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final List<String> size = ['S', 'M', 'L'];
  String selectedSize = '';
  Color _iconColor = Colors.white;
  late bool isInCart;

  @override
  void initState() {
    super.initState();
    final cartBloc = BlocProvider.of<CartBloc>(context);
    isInCart = (cartBloc.state is CartUpdated)
        ? (cartBloc.state as CartUpdated).cartItems.contains(widget.coffeeItem)
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 18),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Detail', style: TextStyle(color: Colors.white)),
            IconButton(
              icon: Icon(Icons.favorite, color: _iconColor),
              onPressed: () {
                setState(
                  () {
                    _iconColor =
                        _iconColor == Colors.white ? Colors.red : Colors.white;
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartUpdated) {
            setState(
              () {
                isInCart = state.cartItems.contains(widget.coffeeItem);
              },
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.coffeeItem.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.coffeeItem.name,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 5),
              Text(widget.coffeeItem.description),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(
                        '4.8',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      Text('(230)')
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/coffee-bean-icon.svg',
                        width: 25,
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                            Colors.brown, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/icons/milk-icon.svg',
                        width: 25,
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                            Colors.brown, BlendMode.srcIn),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5),
              const Divider(color: Colors.black26),
              const SizedBox(height: 5),
              const Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              const Text(
                'A cappuccino is an approximately 150 ml (5oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo.. Read More',
              ),
              const SizedBox(height: 5),
              const Text(
                'size',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final size in size)
                    SizedBox(
                      width: 100,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: selectedSize == size
                                ? Colors.brown
                                : Colors.black,
                            width: selectedSize == size ? 2.0 : 1.0,
                          ),
                          foregroundColor: selectedSize == size
                              ? Colors.brown
                              : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          size,
                          style: selectedSize == size
                              ? const TextStyle(fontWeight: FontWeight.bold)
                              : null,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text('\$ ${widget.coffeeItem.price}'),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 130,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        isInCart
                            ? BlocProvider.of<CartBloc>(context)
                                .add(RemoveItemFromCart(widget.coffeeItem))
                            : BlocProvider.of<CartBloc>(context)
                                .add(AddItemToCart(widget.coffeeItem));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        isInCart ? 'Remove' : 'Add to Cart',
                      ),
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
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
