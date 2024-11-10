import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/application/bloc/auth/auth_bloc.dart';

void showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
              Navigator.of(context).pop();
              context.go('/login');
            },
            child: const Text("Yes, sign me out"),
          ),
        ],
      );
    },
  );
}
