import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/application/bloc/coffee/coffee_bloc.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/data/repositories/auth_repository_impl.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/application/bloc/auth/auth_bloc.dart';
import 'package:myapp/application/bloc/cart/cart_bloc.dart';
import 'package:myapp/application/bloc/favorites/favorites_bloc.dart';
import 'package:myapp/core/routes/app_route.dart';

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
          create: (context) => AuthBloc(authRepository: AuthRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => CoffeeBloc(),
          
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Our wonderful Ethiopian Coffee shop',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
