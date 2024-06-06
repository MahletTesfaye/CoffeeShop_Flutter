import 'package:flutter/material.dart';
import 'package:myapp/src/utils/footer.dart';

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Favorites'),
            Icon(Icons.favorite, color: Colors.red),
          ],
        ),
      ),
      body: const Center(child: Text('No favorites yet')),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 1,
      ),
    );
  }
}
