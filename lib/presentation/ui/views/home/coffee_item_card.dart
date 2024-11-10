import 'package:flutter/material.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/presentation/ui/screens/detail_screen.dart';

class CoffeeItemCard extends StatelessWidget {
  final CoffeeItem coffeeItem;

  const CoffeeItemCard({super.key, required this.coffeeItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(coffeeItem: coffeeItem),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  coffeeItem.image,
                  width: 160,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(coffeeItem.name,
                  style: TextStyle(color: Theme.of(context).highlightColor)),
              Text("Price: \$${coffeeItem.price.toStringAsFixed(2)}",
                  style: TextStyle(color: Theme.of(context).highlightColor)),
            ],
          ),
        ),
      ),
    );
  }
}
