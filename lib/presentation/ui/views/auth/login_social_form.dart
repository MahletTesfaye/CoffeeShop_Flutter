import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/presentation/widgets/buttons/social_button.dart';

class LoginSocialForm extends StatefulWidget {
  const LoginSocialForm({super.key});

  @override
  _LoginSocialFormState createState() => _LoginSocialFormState();
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

class _LoginSocialFormState extends State<LoginSocialForm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialButton(
            label: "Google",
            onPressed: () {
              signInWithGoogle(context);
            },
            icon: SvgPicture.asset('assets/icons/google-color-icon.svg',
                height: 18, width: 18)),
        const SizedBox(width: 10),
        SocialButton(
          label: "Apple",
          onPressed: () {},
          icon: const Icon(Icons.apple),
        ),
      ],
    );
  }
}
