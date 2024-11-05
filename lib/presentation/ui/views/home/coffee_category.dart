import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/presentation/blocs/coffee/coffee_bloc.dart';

class CoffeeCategory extends StatelessWidget {
  final ValueNotifier<String> selectedCategoryNotifier;
  final CoffeeBloc coffeeBloc;

  const CoffeeCategory(
      {super.key,
      required this.coffeeBloc,
      required this.selectedCategoryNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final category in coffeeCategories)
              Container(
                padding: const EdgeInsets.only(left: 6),
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedCategoryNotifier,
                  builder: (context, selectedCategory, _) {
                    return ElevatedButton(
                      onPressed: () {
                        if (category == 'All') {
                          coffeeBloc.add(
                            FetchCoffeeItems(),
                          );
                        } else {
                          coffeeBloc.add(
                            FilterCoffeeByCategory(category),
                          );
                        }
                        selectedCategoryNotifier.value = category;
                      },
                      style: selectedCategory == category
                          ? ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.brown)
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
              ),
          ],
        ),
      ),
    );
  }
}
