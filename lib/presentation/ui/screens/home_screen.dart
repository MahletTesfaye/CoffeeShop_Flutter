import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/application/bloc/coffee/coffee_bloc.dart';
import 'package:myapp/presentation/ui/views/home/coffee_category.dart';
import 'package:myapp/presentation/ui/views/home/coffee_item_card.dart';
import 'package:myapp/presentation/ui/views/home/top_content.dart';
import 'package:myapp/presentation/ui/widgets/footer.dart';

class HomePage extends StatefulWidget {
  final File? profileImage;

  const HomePage({super.key, this.profileImage});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final CoffeeBloc coffeeBloc;
  late final ScrollController _scrollController;
  final ValueNotifier<String> selectedCategoryNotifier =
      ValueNotifier<String>('All');

  @override
  void initState() {
    super.initState();
    coffeeBloc = CoffeeBloc()..add(FetchCoffeeItems());
    _scrollController = ScrollController();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    coffeeBloc.close();
    selectedCategoryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        bloc: coffeeBloc,
        builder: (context, state) {
          if (state is CoffeeLoading) {
            return Container(
              color: appTheme.scaffoldBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(color: appTheme.shadowColor),
              ),
            );
          } else if (state is CoffeeLoaded) {
            final coffeeItems = state.coffeeItems;
            final coffeeCategories = state.coffeeCategories ?? [];

            return Column(
              children: [
                TopContent(
                  profileImage: widget.profileImage,
                  allItems: coffeeItems,
                ),
                const SizedBox(height: 60),
                CoffeeCategory(
                  categories: coffeeCategories,
                  selectedCategoryNotifier: selectedCategoryNotifier,
                  onCategorySelected: (category) {
                    coffeeBloc.add(FilterCoffeeByCategory(category: category));
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Wrap(
                        children: coffeeItems.map((coffeeItem) {
                          return CoffeeItemCard(coffeeItem: coffeeItem);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CoffeeError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }
}
