part of 'coffee_bloc.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();

  @override
  List<Object> get props => [];
}

class FetchCoffeeItems extends CoffeeEvent {}

class FilterCoffeeByCategory extends CoffeeEvent {
  final String category;
  const FilterCoffeeByCategory(this.category);

  @override
  List<Object> get props => [];
}

class ResetCoffeeFilter extends CoffeeEvent {}

