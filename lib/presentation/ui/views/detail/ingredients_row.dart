import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/presentation/theme/app_theme.dart';

class IngredientsRow extends StatelessWidget {
  const IngredientsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.star, color: AppTheme.yellow),
            Text('4.8',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Theme.of(context).highlightColor)),
            Text(
              '(230)',
              style: TextStyle(color: Theme.of(context).highlightColor),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/coffee-bean-icon.svg',
              width: 25,
              height: 25,
              colorFilter:
                  const ColorFilter.mode(AppTheme.brown, BlendMode.srcIn),
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(
              'assets/icons/milk-icon.svg',
              width: 25,
              height: 25,
              colorFilter:
                  const ColorFilter.mode(AppTheme.brown, BlendMode.srcIn),
            ),
          ],
        ),
      ],
    );
  }
}
