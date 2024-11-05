import 'package:flutter/material.dart';
import 'package:myapp/application/services/search_service.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/data/models/coffee_model.dart';
import 'package:myapp/presentation/ui/screens/detail_screen.dart';

class SearchPage extends StatefulWidget {
  final List<CoffeeItem> items;
  const SearchPage({super.key, required this.items});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchService _searchService = SearchService();
  List<CoffeeItem> _filteredItems = [];

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
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
            setState(() {
              _filteredItems = _searchService.searchItems(query, widget.items);
            });
          },
        ),
      ),
      body: _filteredItems.isNotEmpty
          ? ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final coffeeItem = _filteredItems[index];
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
          : const Center(child: Text('No results found')),
    );
  }
}
