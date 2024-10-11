import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/screens/auth/register.dart';
import 'package:myapp/src/screens/auth/bloc/auth_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? generalError;
  bool isVisible = false;
  final bool _isSubmitted = false; // Flag to check if form is submitted

  void _clearErrorMessage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        generalError = null;
      });
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      context.go('/home');
    } catch (error) {
      print('Google Sign-In error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthError) {
          setState(() {
            generalError = state.message; // Other general errors
          });
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  // Email TextField
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _emailController,// Display the general error message below the input fields
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!_isSubmitted) return null; // Skip validation
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _clearErrorMessage();
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Password TextField
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: isVisible ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (!_isSubmitted) return null;
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'The password must contains more than 6 characters.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _clearErrorMessage();
                      },
                    ),
                  ),
                  
                  if (generalError != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      generalError!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              LoginRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(color: Colors.brown)),
                        SizedBox(width: 5),
                        Text("Register"),
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
                              color: Colors.grey,
                            )),
                        Positioned(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.white,
                            child: const Text(
                              'or',
                              style:
                                  TextStyle(color: Colors.brown, fontSize: 18),
                            ),
                          ),
                        ),
                      ])),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {
                          signInWithGoogle(context);
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/google-color-icon.svg',
                          height:
                              18, // Adjust the height to fit within the button
                          width: 18, // Adjust the width as needed
                        ),
                        label: const Text("Google"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, // Google color
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement Apple Login
                        },
                        icon: const Icon(Icons.apple),
                        label: const Text("Apple"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, // Apple color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
