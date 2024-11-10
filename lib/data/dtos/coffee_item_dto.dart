import 'package:myapp/domain/entities/coffee_entity.dart';

class CoffeeItemDTO {
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  final double rate;
  final int review;

  CoffeeItemDTO({
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.rate,
    required this.review,
  });

  factory CoffeeItemDTO.fromJson(Map<String, dynamic> json) {
    return CoffeeItemDTO(
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      review: json['review'] as int,
    );
  }

  CoffeeItem toEntity() {
    return CoffeeItem(
      name: name,
      category: category,
      image: image,
      description: description,
      price: price,
      rate: rate,
      review: review,
    );
  }
}
