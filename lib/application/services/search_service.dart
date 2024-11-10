import 'package:myapp/domain/entities/coffee_entity.dart';

class SearchService {
  List<CoffeeItem> searchItems(String query, List<CoffeeItem> items) {
    return items.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.description.toLowerCase().contains(query.toLowerCase()) ||
          item.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
