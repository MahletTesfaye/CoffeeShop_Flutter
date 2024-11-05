import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/application/services/location_service.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/data/data.dart';
import 'package:myapp/data/models/coffee_model.dart';
import 'package:myapp/presentation/ui/screens/search_screen.dart';
import 'package:myapp/presentation/ui/views/logout_dialog.dart';
import 'package:myapp/application/services/search_service.dart';

class TopContent extends StatefulWidget {
  final File? profileImage;
  const TopContent({super.key, required this.profileImage});

  @override
  State<TopContent> createState() => _TopContentState();
}

class _TopContentState extends State<TopContent> {
  final List<CoffeeItem> allItems = [
    ...{for (var item in coffeeDictionary.values) item}
  ];
  final TextEditingController _searchController = TextEditingController();
  final SearchService _searchService = SearchService();
  List<CoffeeItem> _filteredItems = [];

  void _onSearchChanged(String query) {
    setState(() {
      _filteredItems.clear();
      _filteredItems =
          _searchService.searchItems(query, allItems).toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 240,
          color: AppTheme.darkBlack,
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Location",
                        style: TextStyle(color: AppTheme.white),
                      ),
                      GestureDetector(
                        onTap: LocationService().openMap,
                        child: const Row(
                          children: [
                            Text(
                              "Addis Ababa, Ethiopia",
                              style: TextStyle(color: AppTheme.white),
                            ),
                            Icon(
                              Icons.location_on,
                              color: AppTheme.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => showSignOutDialog(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.grey, width: 2),
                        ),
                        child: widget.profileImage != null
                            ? ClipOval(
                                child: Image.file(
                                  widget.profileImage!,
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 32,
                                  color: AppTheme.grey,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search coffee',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 8),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                    child: SvgPicture.asset('assets/icons/icon_in_search.svg'),
                  ),
                  constraints:
                      const BoxConstraints(minWidth: 200, maxHeight: 40),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                          items: _filteredItems.isNotEmpty
                              ? _filteredItems
                              : allItems),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 175,
          left: 40,
          right: 40,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/coffee4.jpg',
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        color: AppTheme.red,
                        child: const Text(
                          'Promo',
                          style: TextStyle(color: AppTheme.white),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          color: AppTheme.black,
                          child: const Text(
                            'Buy One Get',
                            style: TextStyle(
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          color: AppTheme.black,
                          child: const Text(
                            'One Free',
                            style: TextStyle(
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
