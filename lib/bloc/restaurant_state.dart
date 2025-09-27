part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  final List<MenuItem>? menuItems;
  final bool isLoadingMenu;

  const RestaurantsLoaded(
    this.restaurants, {
    this.menuItems,
    this.isLoadingMenu = false,
  });

  RestaurantsLoaded copyWith({
    List<Restaurant>? restaurants,
    List<MenuItem>? menuItems,
    bool? isLoadingMenu,
  }) {
    return RestaurantsLoaded(
      restaurants ?? this.restaurants,
      menuItems: menuItems ?? this.menuItems,
      isLoadingMenu: isLoadingMenu ?? this.isLoadingMenu,
    );
  }

  @override
  List<Object> get props => [restaurants, menuItems ?? [], isLoadingMenu];
}

class RestaurantSelected extends RestaurantState {
  final Restaurant restaurant;

  const RestaurantSelected(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
