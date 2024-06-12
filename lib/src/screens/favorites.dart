import 'package:flutter/material.dart';
import 'package:myapp/src/components/footer.dart';

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
      body: const Center(child: Text('No favorites yet')),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 1,
      ),
    );
  }
}
