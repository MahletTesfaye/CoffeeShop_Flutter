import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:myapp/core/theme/app_theme.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/coffee1.jpg',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppTheme.black,
                      AppTheme.transparent,
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    child: const Text(
                      "Coffee so good, your taste buds will love it.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 44,
                      ),
                    ),
                  ),
                  const Text(
                    "The best grain, the finest roast, the powerful flavor.",
                    style: TextStyle(
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => {context.go('/login')},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      backgroundColor: AppTheme.white,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Let's get Started",
                          style: TextStyle(color: AppTheme.brown, fontSize: 18),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          color: AppTheme.brown,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
