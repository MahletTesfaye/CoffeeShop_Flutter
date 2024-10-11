import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/components/footer.dart';
import 'package:myapp/src/screens/favorites/bloc/favorites_bloc.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  FavoritesListState createState() => FavoritesListState();
}

class FavoritesListState extends State<FavoritesList> {
  late FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    super.initState();
    _favoritesBloc = FavoritesBloc();
    _favoritesBloc.add(LoadFavorites());
  }

  @override
  void dispose() {
    _favoritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _favoritesBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Favorites', style: TextStyle(color: Colors.white)),
              Icon(Icons.favorite, color: Colors.red),
            ],
          ),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesEmpty) {
              return const Center(child: Text('No favorites yet'));
            } else if (state is FavoritesLoaded) {
              return ListView.builder(
                itemCount: state.favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = state.favoriteItems[index];
                  return ListTile(
                    title: Text(item),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        _favoritesBloc.add(RemoveFavorite(item));
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No favorites yet'));
            }
          },
        ),
        bottomNavigationBar: const BottomNavigation(
          currentIndex: 1,
        ),
      ),
    );
  }
}
