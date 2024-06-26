import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/src/screens/detail.dart';
import 'package:myapp/src/components/footer.dart';
import '../bloc/CoffeeItems/coffee_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final CoffeeBloc _coffeeBloc;
  final List<String> categories = [
    'All',
    'Cappucino',
    'Machiato',
    'Latte',
    'Americano'
  ];
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    _coffeeBloc = CoffeeBloc()..add(FetchCoffeeItems());
    selectedCategory = categories[0];
  }

  @override
  void dispose() {
    _coffeeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 240,
                color: Colors.black87,
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Addis Ababa, Ethiopia",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                            width: 60,
                            height: 80,
                            child: Image.asset('assets/images/profile3.jpg'),
                          ),
                        )
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Search coffee',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                          ),
                          fillColor: Colors.grey[800],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 8),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                            ),
                          ),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 3.0),
                            child: SvgPicture.asset(
                                'assets/icons/icon_in_search.svg'),
                          ),
                          constraints: const BoxConstraints(
                              minWidth: 200, maxWidth: 400, maxHeight: 40)),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
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
                              color: Colors.red,
                              child: const Text(
                                'Promo',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                color: Colors.black,
                                child: const Text(
                                  'Buy One Get',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                color: Colors.black,
                                child: const Text(
                                  'One Free',
                                  style: TextStyle(
                                    color: Colors.white,
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
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final category in categories)
                    Container(
                      padding: const EdgeInsets.only(left: 6),
                      child: ElevatedButton(
                        onPressed: () {
                          if (category == 'All') {
                            _coffeeBloc.add(
                              FetchCoffeeItems(),
                            );
                          } else {
                            _coffeeBloc.add(
                              FilterCoffeeByCategory(category),
                            );
                          }
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        style: selectedCategory == category
                            ? ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown)
                            : null,
                        child: Text(
                          category,
                          style: selectedCategory == category
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<CoffeeBloc, CoffeeState>(
              bloc: _coffeeBloc,
              builder: (context, state) {
                if (state is CoffeeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CoffeeLoaded) {
                  if (state.coffeeItems.isEmpty) {
                    return const Center(
                      child: Text('No items here!'),
                    );
                  } else {
                    return Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            for (final coffeeItem in (state).coffeeItems)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                width: 150,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              coffeeItem: coffeeItem)),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            coffeeItem.image,
                                            width: 160,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(coffeeItem.name),
                                            Text(
                                                "Price: \$ ${coffeeItem.price.toString()}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                } else if (state is CoffeeError) {
                  return Center(
                    child: Text('Error: ${state.errorMessage}'),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 0,
      ),
    );
  }
}
