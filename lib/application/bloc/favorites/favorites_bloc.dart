import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesLoading()) {
    on<AddFavorite>((event, emit) {
      if (state is FavoritesLoaded) {
        emit(FavoritesLoaded(
            List<CoffeeItem>.from((state as FavoritesLoaded).favoriteItems)
              ..insert(0, event.favoriteItem)));
      } else {
        emit(FavoritesLoaded([event.favoriteItem]));
      }
    });

    on<RemoveFavorite>((event, emit) {
      emit(FavoritesLoaded(
          List<CoffeeItem>.from((state as FavoritesLoaded).favoriteItems)
            ..remove(event.favoriteItem)));
    });
  }
}
