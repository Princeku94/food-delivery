import 'package:equatable/equatable.dart';
import 'cart_item.dart';
import 'delivery_address.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  onTheWay,
  delivered,
  cancelled
}

class Order extends Equatable {
  final String id;
  final String restaurantId;
  final List<CartItem> items;
  final DeliveryAddress deliveryAddress;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final String? specialInstructions;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.restaurantId,
    required this.items,
    required this.deliveryAddress,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.createdAt,
    this.specialInstructions,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        items,
        deliveryAddress,
        subtotal,
        deliveryFee,
        tax,
        total,
        status,
        createdAt,
        specialInstructions,
        paymentMethod,
      ];
}
