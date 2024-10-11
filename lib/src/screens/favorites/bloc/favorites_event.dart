part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final String item;

  const AddFavorite(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFavorite extends FavoritesEvent {
  final String item;

  const RemoveFavorite(this.item);

  @override
  List<Object> get props => [item];
}
