import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/screens/auth/bloc/auth_bloc.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? generalError;
  bool isVisible = false;
  bool _isSubmitted = false; // Flag to check if form is submitted

  void _clearErrorMessage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        generalError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthError) {
          // Display general error
          setState(() {
            generalError = state.message;
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
                    "Create Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (!_isSubmitted) return null; // Skip validation until form is submitted
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_isSubmitted) {
                          _clearErrorMessage(); // Clear error after submission
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Email TextField with error handling
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!_isSubmitted) return null; // Skip validation until form is submitted
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_isSubmitted) {
                          _clearErrorMessage(); // Clear error after submission
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Password TextField with error handling
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: isVisible ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Create password',
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
                        if (!_isSubmitted) return null; // Skip validation until form is submitted
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'The password must contain more than 6 characters.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_isSubmitted) {
                          _clearErrorMessage(); // Clear error after submission
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: isVisible ? false : true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (!_isSubmitted) return null; // Skip validation until form is submitted
                        if (value!.isEmpty) {
                          return 'Please enter your password confirmation';
                        } else if (value != _passwordController.text) {
                          return "Password doesn't match.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_isSubmitted) {
                          _clearErrorMessage(); // Clear error after submission
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isSubmitted = true; // Set flag to true on submit
                      });
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignUpRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: TextStyle(color: Colors.brown)),
                        SizedBox(width: 5),
                        Text("Login"),
                      ],
                    ),
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
