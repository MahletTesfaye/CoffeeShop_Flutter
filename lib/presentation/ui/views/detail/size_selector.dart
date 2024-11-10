import 'package:flutter/material.dart';
import 'package:myapp/presentation/theme/app_theme.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final Function(String) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: sizes.map((size) {
        return SizedBox(
          width: 100,
          child: OutlinedButton(
            onPressed: () => onSizeSelected(size),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: selectedSize == size
                    ? AppTheme.brown
                    : appTheme.primaryColor,
                width: selectedSize == size ? 2.0 : 1.0,
              ),
              foregroundColor:
                  selectedSize == size ? AppTheme.brown : AppTheme.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              size,
              style: TextStyle(
                fontWeight:
                    selectedSize == size ? FontWeight.bold : FontWeight.normal,
                color: selectedSize == size
                    ? AppTheme.brown
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
