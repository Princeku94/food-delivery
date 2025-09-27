import 'package:dartz/dartz.dart' hide Order;

import '../entities/order.dart';
import '../entities/cart_item.dart';
import '../entities/delivery_address.dart';
import '../errors/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, Order>> placeOrder({
    required String restaurantId,
    required List<CartItem> items,
    required DeliveryAddress deliveryAddress,
    required String paymentMethod,
    String? specialInstructions,
  });

  Future<Either<Failure, Order>> getOrderById(String orderId);
  Future<Either<Failure, List<Order>>> getOrderHistory();
  Future<Either<Failure, Order>> trackOrder(String orderId);
}
