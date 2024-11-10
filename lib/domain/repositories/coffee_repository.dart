import 'package:myapp/domain/entities/coffee_entity.dart';

abstract class CoffeeRepository {
  Future<List<CoffeeItem>> fetchCoffeeItems();
  Future<List<String>> fetchCoffeeCategories();
}
