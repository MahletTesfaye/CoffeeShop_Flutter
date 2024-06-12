part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final CoffeeItem coffeeItem;

  const AddItemToCart(this.coffeeItem);
  @override
  List<Object> get props => [coffeeItem];
}

class RemoveItemFromCart extends CartEvent {
  final CoffeeItem coffeeItem;

  const RemoveItemFromCart(this.coffeeItem);
  @override
  List<Object> get props => [coffeeItem];
}
