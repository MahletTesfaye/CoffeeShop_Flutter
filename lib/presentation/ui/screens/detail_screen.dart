import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/application/bloc/cart/cart_bloc.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/application/bloc/favorites/favorites_bloc.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
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

  late ValueNotifier<String> selectedSizeNotifier;
  late ValueNotifier<bool> isInCartNotifier;
  late ValueNotifier<bool> isFavoriteNotifier;

  @override
  void initState() {
    super.initState();
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

    selectedSizeNotifier = ValueNotifier<String>('');
    isInCartNotifier = ValueNotifier<bool>(
      cartBloc.state is CartUpdated
          ? (cartBloc.state as CartUpdated)
              .cartItems
              .contains(widget.coffeeItem)
          : false,
    );
    isFavoriteNotifier = ValueNotifier<bool>(
      favoritesBloc.state is FavoritesLoaded
          ? (favoritesBloc.state as FavoritesLoaded)
              .favoriteItems
              .contains(widget.coffeeItem)
          : false,
    );
  }

  @override
  void dispose() {
    selectedSizeNotifier.dispose();
    isInCartNotifier.dispose();
    isFavoriteNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartUpdated) {
              isInCartNotifier.value =
                  state.cartItems.contains(widget.coffeeItem);
            }
          },
        ),
        BlocListener<FavoritesBloc, FavoritesState>(
          listener: (context, state) {
            if (state is FavoritesLoaded) {
              isFavoriteNotifier.value =
                  state.favoriteItems.contains(widget.coffeeItem);
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
              const Text(
                'Detail',
                style: TextStyle(color: AppTheme.white),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isFavoriteNotifier,
                builder: (context, isFavorite, _) {
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFavorite ? AppTheme.red : AppTheme.white,
                    ),
                    onPressed: () {
                      final favoritesBloc =
                          BlocProvider.of<FavoritesBloc>(context);
                      if (isFavorite) {
                        favoritesBloc.add(RemoveFavorite(widget.coffeeItem));
                      } else {
                        favoritesBloc.add(AddFavorite(widget.coffeeItem));
                      }
                    },
                  );
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
                child: Image.network(
                  widget.coffeeItem.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(widget.coffeeItem.name,
                  style: TextStyle(
                      fontSize: 24, color: Theme.of(context).highlightColor)),
              const SizedBox(height: 5),
              const IngredientsRow(),
              const SizedBox(height: 5),
              const Divider(color: AppTheme.lightBlack),
              const SizedBox(height: 5),
              Text(
                'Description',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).highlightColor),
              ),
              const SizedBox(height: 5),
              Text(widget.coffeeItem.description,
                  style: TextStyle(color: Theme.of(context).highlightColor)),
              const SizedBox(height: 5),
              Text(
                'size',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).highlightColor),
              ),
              const SizedBox(height: 5),
              ValueListenableBuilder<String>(
                valueListenable: selectedSizeNotifier,
                builder: (context, selectedSize, _) {
                  return SizeSelector(
                    sizes: size,
                    selectedSize: selectedSize,
                    onSizeSelected: (size) {
                      selectedSizeNotifier.value = size;
                    },
                  );
                },
              ),
              const SizedBox(height: 5),
              ValueListenableBuilder<bool>(
                valueListenable: isInCartNotifier,
                builder: (context, isInCart, _) {
                  return PriceActions(
                    price: widget.coffeeItem.price,
                    isInCart: isInCart,
                    coffeeItem: widget.coffeeItem,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
