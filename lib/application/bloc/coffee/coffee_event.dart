part of 'coffee_bloc.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object> get props => [];
}

class FetchCoffeeItems extends CoffeeEvent {}

class FetchCoffeeCategories extends CoffeeEvent {}

class FilterCoffeeByCategory extends CoffeeEvent {
  final String category;
  const FilterCoffeeByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class ResetCoffeeFilter extends CoffeeEvent {}
