import 'package:go_router/go_router.dart';
import 'package:myapp/presentation/ui/screens/auth/login_screen.dart';
import 'package:myapp/presentation/ui/screens/auth/register_screen.dart';
import 'package:myapp/presentation/ui/screens/cart_screen.dart';
import 'package:myapp/presentation/ui/screens/favorites_screen.dart';
import 'package:myapp/presentation/ui/screens/home_screen.dart';
import 'package:myapp/presentation/ui/screens/orders_screen.dart';
import 'package:myapp/presentation/ui/screens/welcome_screen.dart';

final GoRouter router = GoRouter(
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
