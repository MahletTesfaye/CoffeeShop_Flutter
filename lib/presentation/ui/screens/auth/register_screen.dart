import 'package:flutter/material.dart';
import 'package:myapp/presentation/ui/views/auth/register_input_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const RegisterInputForm(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(width: 5),
                    Text("Login",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
