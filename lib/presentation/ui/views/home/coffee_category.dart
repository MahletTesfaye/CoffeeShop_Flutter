import 'package:flutter/material.dart';
import 'package:myapp/presentation/theme/app_theme.dart';

class CoffeeCategory extends StatelessWidget {
  final List<String> categories;
  final ValueNotifier<String> selectedCategoryNotifier;
  final Function(String) onCategorySelected;

  const CoffeeCategory({
    super.key,
    required this.categories,
    required this.selectedCategoryNotifier,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return Container(
              padding: const EdgeInsets.only(left: 6),
              child: ValueListenableBuilder<String>(
                valueListenable: selectedCategoryNotifier,
                builder: (context, selectedCategory, _) {
                  return ElevatedButton(
                    onPressed: () {
                      onCategorySelected(category);
                      selectedCategoryNotifier.value = category;
                    },
                    style: selectedCategory == category
                        ? ElevatedButton.styleFrom(backgroundColor: AppTheme.brown)
                        : null,
                    child: Text(
                      category,
                      style: selectedCategory == category
                          ? const TextStyle(color: AppTheme.white)
                          : TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
