import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/bloc/CartItems/cart_bloc.dart';
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
    return BlocProvider(
      create: (context) => CartBloc(),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Our wonderful Ethiopian Coffee shop',
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/welcome',
  routes: <RouteBase>[
    GoRoute(
      name: '/welcome',
      path: '/welcome',
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
