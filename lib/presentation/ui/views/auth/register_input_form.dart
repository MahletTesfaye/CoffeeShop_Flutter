import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/core/validators/auth_validator.dart';
import 'package:myapp/presentation/blocs/auth/auth_bloc.dart';
import 'package:myapp/presentation/widgets/inputs/custom_text_input.dart';

class RegisterInputForm extends StatefulWidget {
  const RegisterInputForm({super.key});

  @override
  _RegisterInputFormState createState() => _RegisterInputFormState();
}

class _RegisterInputFormState extends State<RegisterInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  File? _profileImage;
  bool _isVisible = false;
  bool _isSubmitted = false; // Flag to check if form is submitted

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Create Account",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _selectProfileImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? const Icon(Icons.person, size: 40, color: AppTheme.grey)
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextInput(
            labelText: 'Username',
            hintText: 'Enter your username',
            controller: _usernameController,
            validator: (value) {
              if (!_isSubmitted) return null;
              return AuthValidator.validateUsername(value);
            },
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            labelText: 'Email',
            hintText: 'Enter your email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (!_isSubmitted) return null;
              return AuthValidator.validateEmail(value);
            },
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            labelText: 'Create Password',
            hintText: 'Enter your password',
            controller: _passwordController,
            obscureText: !_isVisible,
            validator: (value) {
              if (!_isSubmitted) return null;
              return AuthValidator.validatePassword(value);
            },
            suffixIcon: IconButton(
              icon: Icon(
                _isVisible ? Icons.visibility : Icons.visibility_off,
                color: AppTheme.grey,
              ),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            controller: _confirmPasswordController,
            obscureText: !_isVisible,
            validator: (value) {
              if (!_isSubmitted) return null;
              return AuthValidator.validateConfirmPassword(value, _passwordController.text);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isSubmitted = true;
              });
              if (_formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(SignUpRequested(
                  email: _emailController.text,
                  password: _passwordController.text,
                ));
              }
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
