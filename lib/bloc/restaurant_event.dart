part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurants extends RestaurantEvent {
  final bool forceReload;

  const LoadRestaurants({this.forceReload = false});

  @override
  List<Object> get props => [forceReload];
}

class SearchRestaurants extends RestaurantEvent {
  final String query;

  const SearchRestaurants(this.query);

  @override
  List<Object> get props => [query];
}

class SelectRestaurant extends RestaurantEvent {
  final String restaurantId;

  const SelectRestaurant(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class LoadMenuItems extends RestaurantEvent {
  final String restaurantId;

  const LoadMenuItems(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}
