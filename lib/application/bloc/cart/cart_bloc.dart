import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';

part 'cart_state.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
  }

  Future<void> _onAddItemToCart(
      AddItemToCart event, Emitter<CartState> emit) async {
    try {
      if (state is CartUpdated) {
        final updatedCart =
            List<CoffeeItem>.from((state as CartUpdated).cartItems)
              ..insert(0, event.coffeeItem);
        emit(CartUpdated(updatedCart));
      } else {
        emit(CartUpdated([event.coffeeItem]));
      }
    } catch (e) {
      emit(const CartError(message: 'Failed to add item to cart'));
    }
  }

  Future<void> _onRemoveItemFromCart(
      RemoveItemFromCart event, Emitter<CartState> emit) async {
    try {
      if (state is CartUpdated) {
        final updatedCart =
            List<CoffeeItem>.from((state as CartUpdated).cartItems)
              ..remove(event.coffeeItem);
        emit(CartUpdated(updatedCart));
      } else {
        emit(const CartError(message: 'Failed to remove item from cart'));
      }
    } catch (e) {
      emit(const CartError(message: 'Failed to remove item from cart'));
    }
  }
}
