import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.network(
          //   "https://img.freepik.com/free-photo/close-up-coffee-cup-wooden-table-steam-rising-generative-ai_188544-8921.jpg?w=826&t=st=1717004824~exp=1717005424~hmac=ba66490ea0c0ecc79d3728804504b0b5f386ae1bcaa14c2f69ad626eb105ab77",
          //    fit: BoxFit.cover,
          // ),
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
                      Colors.black,
                      Colors.transparent,
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
                        color: Colors.white,
                        fontSize: 44,
                      ),
                    ),
                  ),
                  const Text(
                    "The best grain, the finest roast, the powerful flavor.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => {context.go('/home')},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Let's get Started",
                          style: TextStyle(color: Colors.brown, fontSize: 18),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.brown,
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
