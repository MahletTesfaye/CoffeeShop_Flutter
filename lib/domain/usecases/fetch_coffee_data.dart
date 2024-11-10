import 'package:myapp/data/repositories/coffee_repository_impl.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/domain/repositories/coffee_repository.dart';

class FetchCoffeeItemsUseCase {
  final CoffeeRepository _coffeeRepository = CoffeeRepositoryImpl();

  FetchCoffeeItemsUseCase();

  Future<List<CoffeeItem>> fetchCoffeeItem() async {
    return await _coffeeRepository.fetchCoffeeItems();
  }

  Future<List<String>> fetchCoffeeCategories() async {
    return await _coffeeRepository.fetchCoffeeCategories();
  }
}
