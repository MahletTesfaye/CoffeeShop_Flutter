import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/common/footer.dart';
import 'package:myapp/src/presentation/detail/detail.dart';
import 'package:myapp/src/presentation/favorites/bloc/favorites_bloc.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  FavoritesListState createState() => FavoritesListState();
}

class FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if (state is FavoritesLoaded) {
            if (state.favoriteItems.isEmpty) {
              return const Center(
                child: Text("No favorite items!"),
              );
            } else {
              return ListView.builder(
                itemCount: state.favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = state.favoriteItems[index];
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
                          child: Image.asset(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(item.name,
                            style: const TextStyle(color: Colors.brown)),
                        subtitle: Text('\$ ${item.price.toString()}',
                            style: const TextStyle(color: Colors.brown)),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () {
                            BlocProvider.of<FavoritesBloc>(context)
                                .add(RemoveFavorite(item));
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text('No favorite items!'));
          }
        },
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 1,
      ),
    );
  }
}
