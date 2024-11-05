import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/presentation/blocs/cart/cart_bloc.dart';
import 'package:myapp/data/models/coffee_model.dart';
import 'package:myapp/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:myapp/presentation/ui/views/detail/ingredients_row.dart';
import 'package:myapp/presentation/ui/views/detail/price_actions.dart';
import 'package:myapp/presentation/ui/views/detail/size_selector.dart';

class DetailPage extends StatefulWidget {
  final CoffeeItem coffeeItem;
  const DetailPage({super.key, required this.coffeeItem});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final List<String> size = ['S', 'M', 'L'];
  String selectedSize = '';
  late bool isInCart;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

    isInCart = (cartBloc.state is CartUpdated)
        ? (cartBloc.state as CartUpdated).cartItems.contains(widget.coffeeItem)
        : false;

    isFavorite = (favoritesBloc.state is FavoritesLoaded)
        ? (favoritesBloc.state as FavoritesLoaded)
            .favoriteItems
            .contains(widget.coffeeItem)
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartUpdated) {
              setState(() {
                isInCart = state.cartItems.contains(widget.coffeeItem);
              });
            }
          },
        ),
        BlocListener<FavoritesBloc, FavoritesState>(
          listener: (context, state) {
            if (state is FavoritesLoaded) {
              setState(() {
                isFavorite = state.favoriteItems.contains(widget.coffeeItem);
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.brown,
          foregroundColor: AppTheme.white,
          titleTextStyle: const TextStyle(fontSize: 18),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Detail', style: TextStyle(color: AppTheme.white)),
              IconButton(
                icon: Icon(Icons.favorite,
                    color: isFavorite ? AppTheme.red : AppTheme.white),
                onPressed: () {
                  final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
                  setState(() {
                    if (isFavorite) {
                      favoritesBloc.add(RemoveFavorite(widget.coffeeItem));
                    } else {
                      favoritesBloc.add(AddFavorite(widget.coffeeItem));
                    }
                  });
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
              const IngredientsRow(),
              const SizedBox(height: 5),
              const Divider(color: AppTheme.lightBlack),
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
              SizeSelector(
                sizes: size,
                selectedSize: selectedSize,
                onSizeSelected: (size) => setState(() {
                  selectedSize = size;
                }),
              ),
              const SizedBox(height: 5),
              PriceActions(
                  price: widget.coffeeItem.price,
                  isInCart: isInCart,
                  coffeeItem: widget.coffeeItem)
            ],
          ),
        ),
      ),
    );
  }
}
