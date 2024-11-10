import 'package:flutter/material.dart';
import 'package:myapp/application/services/search_service.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/presentation/theme/app_theme.dart';
import 'package:myapp/presentation/ui/screens/detail_screen.dart';

class SearchPage extends StatefulWidget {
  final List<CoffeeItem> items;
  const SearchPage({super.key, required this.items});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchService _searchService = SearchService();

  late ValueNotifier<List<CoffeeItem>> _filteredItemsNotifier;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredItemsNotifier = ValueNotifier<List<CoffeeItem>>(widget.items);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _filteredItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.brown,
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: const TextStyle(color: AppTheme.white),
          cursorColor: AppTheme.white,
          decoration: const InputDecoration(
            focusColor: AppTheme.white,
            hintStyle: TextStyle(color: AppTheme.lightBrown),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            _filteredItemsNotifier.value =
                _searchService.searchItems(query, widget.items);
          },
        ),
      ),
      body: ValueListenableBuilder<List<CoffeeItem>>(
        valueListenable: _filteredItemsNotifier,
        builder: (context, filteredItems, _) {
          return filteredItems.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final coffeeItem = filteredItems[index];
                    return ListTile(
                      title: Text(coffeeItem.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(coffeeItem: coffeeItem),
                          ),
                        );
                      },
                    );
                  },
                )
              : const Center(child: Text('No results found'));
        },
      ),
    );
  }
}
