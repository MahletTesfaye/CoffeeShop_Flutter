import 'package:flutter/material.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/presentation/ui/screens/auth/register_screen.dart';
import 'package:myapp/presentation/ui/views/auth/login_input_form.dart';
import 'package:myapp/presentation/ui/views/auth/login_social_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const LoginInputForm(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    const SizedBox(width: 5),
                    Text("Register",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: Stack(alignment: Alignment.center, children: [
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: const Divider(
                          thickness: 1,
                          color: AppTheme.grey,
                        )),
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const Text(
                          'or',
                          style: TextStyle(color: AppTheme.brown, fontSize: 18),
                        ),
                      ),
                    ),
                  ])),
              const SizedBox(height: 10),
              const LoginSocialForm(),
            ],
          ),
        ),
      ),
    );
  }
}
