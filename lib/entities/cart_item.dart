import 'package:equatable/equatable.dart';
import 'menu_item.dart';

class CartItem extends Equatable {
  final MenuItem menuItem;
  final int quantity;
  final List<String> selectedCustomizations;
  final String specialInstructions;

  const CartItem({
    required this.menuItem,
    required this.quantity,
    this.selectedCustomizations = const [],
    this.specialInstructions = '',
  });

  double get totalPrice => menuItem.price * quantity;

  CartItem copyWith({
    MenuItem? menuItem,
    int? quantity,
    List<String>? selectedCustomizations,
    String? specialInstructions,
  }) {
    return CartItem(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      selectedCustomizations:
          selectedCustomizations ?? this.selectedCustomizations,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object> get props => [
        menuItem,
        quantity,
        selectedCustomizations,
        specialInstructions,
      ];
}
