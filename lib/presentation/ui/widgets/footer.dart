import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
// import 'package:myapp/presentation/theme/app_theme.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  const BottomNavigation({super.key, required this.currentIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: GNav(
        gap: 10,
        tabActiveBorder: const Border(
          bottom: BorderSide(color: AppTheme.brown, width: 1),
        ),
        color: AppTheme.brown,
        activeColor: AppTheme.brown,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        selectedIndex: widget.currentIndex,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              context.go('/home');
            },
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Favorite',
            onPressed: () {
              context.go('/favorites');
            },
          ),
          GButton(
            icon: Icons.list_alt,
            text: 'Orders',
            onPressed: () {
              context.go('/orders');
            },
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
      ),
    );
  }
}
