import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/presentation/auth/bloc/auth_bloc.dart';
import 'package:myapp/src/presentation/auth/repositories/auth_repository.dart';
import 'package:myapp/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:myapp/src/presentation/auth/login.dart';
import 'package:myapp/src/presentation/auth/register.dart';
import 'package:myapp/src/presentation/cart/cart.dart';
import 'package:myapp/src/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:myapp/src/presentation/favorites/favorites.dart';
import 'package:myapp/src/presentation/home/home.dart';
import 'package:myapp/src/presentation/orders/orders.dart';
import 'package:myapp/src/presentation/welcome/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(),
        ),
      ],
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
      name: '/login',
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      name: '/register',
      path: '/register',
      builder: (context, state) {
        return const RegisterPage();
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
