import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/data/dtos/coffee_item_dto.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/domain/repositories/coffee_repository.dart';

class CoffeeRepositoryImpl extends CoffeeRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CoffeeRepositoryImpl();

  @override
  Future<List<CoffeeItem>> fetchCoffeeItems() async {
    try {
      final querySnapshot = await _firebaseFirestore.collection('coffee').get();
      return querySnapshot.docs
          .map((doc) => CoffeeItemDTO.fromJson(doc.data()).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch coffee items: $e');
    }
  }

  @override
  Future<List<String>> fetchCoffeeCategories() async {
    try {
      final querySnapshot = await _firebaseFirestore.collection('coffee').get();
      final categories = querySnapshot.docs
          .map((doc) => doc['category'] as String)
          .toSet()
          .toList();
      categories.insert(0, 'All');
      return categories;
    } catch (e) {
      throw Exception('Failed to fetch coffee categories: $e');
    }
  }
}
