import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../entities/restaurant.dart';
import '../../../entities/menu_item.dart';
import '../../../repositories/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

@injectable
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc(this.repository) : super(RestaurantInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<SearchRestaurants>(_onSearchRestaurants);
    on<SelectRestaurant>(_onSelectRestaurant);
    on<LoadMenuItems>(_onLoadMenuItems);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());

    final result = await repository.getRestaurants();

    result.fold(
      (failure) => emit(RestaurantError(failure.message)),
      (restaurants) => emit(RestaurantsLoaded(restaurants)),
    );
  }

  Future<void> _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LoadRestaurants());
      return;
    }

    emit(RestaurantLoading());

    final result = await repository.searchRestaurants(event.query);

    result.fold(
      (failure) => emit(RestaurantError(failure.message)),
      (restaurants) => emit(RestaurantsLoaded(restaurants)),
    );
  }

  Future<void> _onSelectRestaurant(
    SelectRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    final result = await repository.getRestaurantById(event.restaurantId);

    result.fold(
      (failure) => emit(RestaurantError(failure.message)),
      (restaurant) => emit(RestaurantSelected(restaurant)),
    );
  }

  Future<void> _onLoadMenuItems(
    LoadMenuItems event,
    Emitter<RestaurantState> emit,
  ) async {
    // If current state is RestaurantsLoaded, preserve it
    if (state is RestaurantsLoaded) {
      final currentState = state as RestaurantsLoaded;
      emit(currentState.copyWith(isLoadingMenu: true));

      final result = await repository.getMenuItems(event.restaurantId);

      result.fold(
        (failure) => emit(RestaurantError(failure.message)),
        (items) => emit(currentState.copyWith(
          menuItems: items,
          isLoadingMenu: false,
        )),
      );
    } else {
      // Fallback: just load menu items without preserving restaurant list
      final result = await repository.getMenuItems(event.restaurantId);

      result.fold(
        (failure) => emit(RestaurantError(failure.message)),
        (items) => emit(RestaurantsLoaded([], menuItems: items)),
      );
    }
  }
}
