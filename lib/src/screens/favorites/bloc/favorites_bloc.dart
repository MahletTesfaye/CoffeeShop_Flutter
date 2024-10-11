import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<String> _favorites = [];

  FavoritesBloc() : super(FavoritesLoading()) {
    on<LoadFavorites>((event, emit) {
      if (_favorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(List.from(_favorites)));
      }
    });

    on<AddFavorite>((event, emit) {
      _favorites.add(event.item);
      emit(FavoritesLoaded(List.from(_favorites)));
    });

    on<RemoveFavorite>((event, emit) {
      _favorites.remove(event.item);
      if (_favorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(List.from(_favorites)));
      }
    });
  }
}

