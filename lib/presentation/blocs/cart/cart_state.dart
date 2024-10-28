part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CoffeeItem> cartItems;

  const CartUpdated(this.cartItems);
  @override
  List<Object> get props => [cartItems];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});
  @override
  List<Object> get props => [message];
}
