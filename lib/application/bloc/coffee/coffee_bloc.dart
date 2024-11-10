import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/domain/entities/coffee_entity.dart';
import 'package:myapp/domain/usecases/fetch_coffee_data.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final FetchCoffeeItemsUseCase _fetchCoffeeItemsUseCase =
      FetchCoffeeItemsUseCase();
  List<CoffeeItem> _allCoffeeItems = [];
  List<String> _coffeeCategories = [];

  CoffeeBloc() : super(CoffeeInitial()) {
    on<FetchCoffeeItems>(_onFetchCoffeeItems);
    on<FilterCoffeeByCategory>(_onFilterCoffeeByCategory);
  }

  void _onFetchCoffeeItems(
      FetchCoffeeItems event, Emitter<CoffeeState> emit) async {
    try {
      emit(CoffeeLoading());
      _allCoffeeItems = await _fetchCoffeeItemsUseCase.fetchCoffeeItem();
      _coffeeCategories =
          await _fetchCoffeeItemsUseCase.fetchCoffeeCategories();
      emit(CoffeeLoaded(
          coffeeItems: _allCoffeeItems, coffeeCategories: _coffeeCategories));
    } catch (e) {
      emit(CoffeeError(errorMessage: e.toString()));
    }
  }

  void _onFilterCoffeeByCategory(
      FilterCoffeeByCategory event, Emitter<CoffeeState> emit) async {
    if (state is CoffeeLoaded) {
      final coffeeItems = event.category == 'All'
          ? _allCoffeeItems
          : _allCoffeeItems
              .where((coffeeItem) => coffeeItem.category == event.category)
              .toList();

      emit(CoffeeLoaded(
          coffeeItems: coffeeItems, coffeeCategories: _coffeeCategories));
    }
  }
}
