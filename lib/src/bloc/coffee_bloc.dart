import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/src/utils/data.dart';
import '../models/coffee_model.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  List<CoffeeItem> _allCoffeeItems = [];

  CoffeeBloc() : super(CoffeeInitial()) {
    on<FetchCoffeeItems>(_onFetchCoffeeItems);
    on<FilterCoffeeByCategory>(_onFilterCoffeeByCategory);
  }

  void _onFetchCoffeeItems(
      FetchCoffeeItems event, Emitter<CoffeeState> emit) async {
    try {
      emit(CoffeeLoading());
      _allCoffeeItems = coffeeDictionary.values
          .map(
            (data) => CoffeeItem(
              id: data.id,
              name: data.name,
              category: data.category,
              image: data.image,
              description: data.description,
              price: data.price,
            ),
          )
          .toList();
      emit(CoffeeLoaded(coffeeItems: _allCoffeeItems));
    } catch (e) {
      emit(CoffeeError(errorMessage: e.toString()));
    }
  }

  void _onFilterCoffeeByCategory(
      FilterCoffeeByCategory event, Emitter<CoffeeState> emit) async {
    if (state is CoffeeLoaded) {
      final coffeeItems = _allCoffeeItems;
      final filteredCoffeeItems = coffeeItems
          .where((coffeeItem) => coffeeItem.category == event.category)
          .toList();
      emit(CoffeeLoaded(coffeeItems: filteredCoffeeItems));
    }
  }

}
