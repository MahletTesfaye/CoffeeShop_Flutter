import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/validators/auth_validator.dart';
import 'package:myapp/presentation/blocs/auth/auth_bloc.dart';
import 'package:myapp/presentation/widgets/inputs/custom_text_input.dart';
import 'package:myapp/presentation/widgets/inputs/form_wrapper.dart';

class LoginInputForm extends StatefulWidget {
  const LoginInputForm({super.key});

  @override
  _LoginInputFormState createState() => _LoginInputFormState();
}

class _LoginInputFormState extends State<LoginInputForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? generalError;
  bool isVisible = false;
  bool _isSubmitted = false;

  void _clearErrorMessage() {
    setState(() {
      generalError = null;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthError) {
          setState(() {
            generalError = state.message;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWrapper(
            title: "Login",
            inputFields: [
              CustomTextInput(
                labelText: "Email",
                hintText: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AuthValidator.validateEmail(value),
                onChanged: (value) {
                  if (_isSubmitted) {
                    _clearErrorMessage();
                  }
                },
              ),
              CustomTextInput(
                labelText: "Password",
                hintText: "Password",
                controller: _passwordController,
                obscureText: !isVisible,
                suffixIcon: IconButton(
                  icon: isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                ),
                validator: (value) => AuthValidator.validatePassword(value),
                onChanged: (value) {
                  if (_isSubmitted) {
                    _clearErrorMessage();
                  }
                },
              ),
            ],
            onSubmit: () {
              setState(() {
                _isSubmitted = true;
              });
              context.read<AuthBloc>().add(
                    LoginRequested(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
            },
            submitTitle: "Login"),
      ),
    );
  }
}
