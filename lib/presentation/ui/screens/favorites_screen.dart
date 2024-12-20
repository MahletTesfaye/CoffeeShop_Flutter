import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/presentation/ui/widgets/footer.dart';
import 'package:myapp/presentation/ui/screens/detail_screen.dart';
import 'package:myapp/application/bloc/favorites/favorites_bloc.dart';

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
        backgroundColor: AppTheme.brown,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Favorites', style: TextStyle(color: AppTheme.white)),
            Icon(Icons.favorite, color: AppTheme.red),
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
                          icon: const Icon(Icons.remove_circle,
                              color: AppTheme.red),
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
