part of 'coffee_bloc.dart';

class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object> get props => [];
}

class CoffeeInitial extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}

class CoffeeLoaded extends CoffeeState {
  final List<CoffeeItem> coffeeItems;
  final List<String>? coffeeCategories;

  const CoffeeLoaded({required this.coffeeItems, this.coffeeCategories});

  @override
  List<Object> get props => [coffeeItems, coffeeCategories!];
}

class CoffeeError extends CoffeeState {
  final String errorMessage;

  const CoffeeError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
