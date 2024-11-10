import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/application/services/google_sign_in_service.dart';
import 'package:myapp/presentation/ui/widgets/buttons/social_button.dart';

class LoginSocialForm extends StatefulWidget {
  const LoginSocialForm({super.key});

  @override
  _LoginSocialFormState createState() => _LoginSocialFormState();
}

class _LoginSocialFormState extends State<LoginSocialForm> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  bool _isLoading = false;

  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _googleSignInService.signInWithGoogle();

      if (mounted) {
        if (userCredential != null) {
          context.go('/home');
        } else {
          _showSnackBar('Google Sign-In failed');
        }
      }
    } catch (error) {
      if (mounted) {
        _showSnackBar('Error signing in: $error');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialButton(
              label: "Google",
              onPressed: () {
                _isLoading ? null : signInWithGoogle;
              },
              icon: SvgPicture.asset(
                'assets/icons/google-color-icon.svg',
                height: 18,
                width: 18,
              ),
            ),
            const SizedBox(width: 10),
            SocialButton(
              label: "Apple",
              onPressed: () {},
              icon: const Icon(Icons.apple),
            ),
          ],
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
