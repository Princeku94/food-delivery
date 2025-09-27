part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrder extends OrderEvent {
  final String restaurantId;
  final List<CartItem> items;
  final DeliveryAddress deliveryAddress;
  final String paymentMethod;
  final String? specialInstructions;

  const PlaceOrder({
    required this.restaurantId,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.specialInstructions,
  });

  @override
  List<Object?> get props => [
        restaurantId,
        items,
        deliveryAddress,
        paymentMethod,
        specialInstructions,
      ];
}

class TrackOrder extends OrderEvent {
  final String orderId;

  const TrackOrder(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class LoadOrderHistory extends OrderEvent {}
