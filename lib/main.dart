import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/screens/cart.dart';
import 'package:myapp/src/screens/favorites.dart';
import 'package:myapp/src/screens/home.dart';
import 'package:myapp/src/screens/orders.dart';
import 'package:myapp/src/screens/welcome.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Our wonderful Ethiopian Coffee shop',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const WelcomePage();
      },
    ),
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: '/favorites',
      path: '/favorites',
      builder: (context, state) {
        return const FavoritesList();
      },
    ),
    GoRoute(
      name: '/orders',
      path: '/orders',
      builder: (context, state) {
        return const OrdersList();
      },
    ),
    GoRoute(
      name: '/cart',
      path: '/cart',
      builder: (context, state) {
        return const AddToCart();
      },
    ),
  ],
);
