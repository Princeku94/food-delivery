part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final Restaurant? restaurant;

  const CartState({
    this.items = const [],
    this.restaurant,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => restaurant?.deliveryFee ?? 0;

  double get tax => subtotal * 0.08;

  double get total => subtotal + deliveryFee + tax;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    List<CartItem>? items,
    Restaurant? restaurant,
  }) {
    return CartState(
      items: items ?? this.items,
      restaurant: restaurant ?? this.restaurant,
    );
  }

  @override
  List<Object?> get props => [items, restaurant];
}
