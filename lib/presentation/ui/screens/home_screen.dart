import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/models/coffee_model.dart';
import 'package:myapp/presentation/blocs/coffee/coffee_bloc.dart';
import 'package:myapp/presentation/ui/views/home/coffee_category.dart';
import 'package:myapp/presentation/ui/views/home/coffee_item_card.dart';
import 'package:myapp/presentation/ui/views/home/top_content.dart';
import 'package:myapp/presentation/widgets/footer.dart';

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
    return Scaffold(
      body: Column(
        children: [
          TopContent(profileImage: widget.profileImage),
          const SizedBox(height: 60),
          CoffeeCategory(
            coffeeBloc: coffeeBloc,
            selectedCategoryNotifier: selectedCategoryNotifier,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<CoffeeBloc, CoffeeState>(
              bloc: coffeeBloc,
              builder: (context, state) {
                if (state is CoffeeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CoffeeLoaded) {
                  return state.coffeeItems.isEmpty
                      ? const Center(child: Text('No items available!'))
                      : _buildCoffeeItemsGrid(state.coffeeItems);
                } else if (state is CoffeeError) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildCoffeeItemsGrid(List<CoffeeItem> coffeeItems) {
    return Scrollbar(
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
    );
  }
}
