part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoritesEvent {
  final CoffeeItem favoriteItem;

  const AddFavorite(this.favoriteItem);

  @override
  List<Object> get props => [favoriteItem];
}

class RemoveFavorite extends FavoritesEvent {
  final CoffeeItem favoriteItem;

  const RemoveFavorite(this.favoriteItem);

  @override
  List<Object> get props => [favoriteItem];
}
