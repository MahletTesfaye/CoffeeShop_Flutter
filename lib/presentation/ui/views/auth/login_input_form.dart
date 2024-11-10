import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/validators/auth_validator.dart';
import 'package:myapp/application/bloc/auth/auth_bloc.dart';
import 'package:myapp/presentation/ui/widgets/inputs/custom_text_input.dart';
import 'package:myapp/presentation/ui/widgets/inputs/form_wrapper.dart';

class LoginInputForm extends StatefulWidget {
  const LoginInputForm({super.key});

  @override
  _LoginInputFormState createState() => _LoginInputFormState();
}

class _LoginInputFormState extends State<LoginInputForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<String?> _generalErrorNotifier =
      ValueNotifier<String?>(null);
  final ValueNotifier<bool> _isVisibleNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isSubmittedNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _generalErrorNotifier.dispose();
    _isVisibleNotifier.dispose();
    _isSubmittedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthError) {
          _generalErrorNotifier.value = state.message;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWrapper(
          title: "Login",
          inputFields: [
            ValueListenableBuilder<String?>(
              valueListenable: _generalErrorNotifier,
              builder: (context, generalError, child) {
                return CustomTextInput(
                  labelText: "Email",
                  hintText: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => AuthValidator.validateEmail(value),
                  errorText: generalError,
                  onChanged: (value) {
                    if (_isSubmittedNotifier.value) {
                      _generalErrorNotifier.value = null;
                    }
                  },
                );
              },
            ),
            ValueListenableBuilder<String?>(
              valueListenable: _generalErrorNotifier,
              builder: (context, generalError, child) {
                return CustomTextInput(
                  labelText: "Password",
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: !_isVisibleNotifier.value,
                  suffixIcon: IconButton(
                    icon: _isVisibleNotifier.value
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      _isVisibleNotifier.value = !_isVisibleNotifier.value;
                    },
                  ),
                  validator: (value) => AuthValidator.validatePassword(value),
                  onChanged: (value) {
                    if (_isSubmittedNotifier.value) {
                      _generalErrorNotifier.value = null;
                    }
                  },
                );
              },
            ),
          ],
          onSubmit: () {
            _isSubmittedNotifier.value = true;
            context.read<AuthBloc>().add(
                  LoginRequested(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
          },
          submitTitle: "Login",
        ),
      ),
    );
  }
}
