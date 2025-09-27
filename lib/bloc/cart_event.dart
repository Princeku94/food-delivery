part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final MenuItem item;
  final int quantity;
  final List<String> customizations;
  final String specialInstructions;

  const AddToCart({
    required this.item,
    required this.quantity,
    this.customizations = const [],
    this.specialInstructions = '',
  });

  @override
  List<Object?> get props =>
      [item, quantity, customizations, specialInstructions];
}

class RemoveFromCart extends CartEvent {
  final String itemId;

  const RemoveFromCart(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class UpdateQuantity extends CartEvent {
  final String itemId;
  final int quantity;

  const UpdateQuantity(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}

class ClearCart extends CartEvent {}

class SetRestaurant extends CartEvent {
  final Restaurant restaurant;

  const SetRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}
