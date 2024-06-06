import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/models/coffee_model.dart';

class DetailPage extends StatelessWidget {
  final CoffeeItem coffeeItem;
  final List<String> size = ['S', 'M', 'L'];
  DetailPage({super.key, required this.coffeeItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_sharp),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text('Detail'),
                const Icon(Icons.favorite),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                coffeeItem.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              coffeeItem.name,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 5),
            Text(coffeeItem.description),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                      '4.8',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    Text('(230)')
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/coffee-bean-icon.svg',
                      width: 25,
                      height: 25,
                      colorFilter:
                          const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      'assets/icons/milk-icon.svg',
                      width: 25,
                      height: 25,
                      colorFilter:
                          const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 7),
            const Divider(color: Colors.black26),
            const SizedBox(height: 7),
            const Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 7),
            const Text(
              'A cappuccino is an approximately 150 ml (5oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo.. Read More',
            ),
            const SizedBox(height: 7),
            const Text(
              'size',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final size in size)
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.brown),
                        foregroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(size),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Price',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text('\$ ${coffeeItem.price}'),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/cart');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 105,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/orders');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
