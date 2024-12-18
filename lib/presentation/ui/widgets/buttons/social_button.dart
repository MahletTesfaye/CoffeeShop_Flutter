import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Widget icon;

  const SocialButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(label),
      icon: icon,
      onPressed: onPressed,
    );
  }
}
