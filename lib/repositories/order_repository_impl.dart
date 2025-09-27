import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;
import '../errors/failures.dart';
import '../../entities/order.dart';
import '../../entities/cart_item.dart';
import '../../entities/delivery_address.dart';
import '../../repositories/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final List<Order> _orders = [];

  @override
  Future<Either<Failure, Order>> placeOrder({
    required String restaurantId,
    required List<CartItem> items,
    required DeliveryAddress deliveryAddress,
    required String paymentMethod,
    String? specialInstructions,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
      final deliveryFee = 2.99;
      final tax = subtotal * 0.08;
      final total = subtotal + deliveryFee + tax;

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        restaurantId: restaurantId,
        items: items,
        deliveryAddress: deliveryAddress,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        tax: tax,
        total: total,
        status: OrderStatus.confirmed,
        createdAt: DateTime.now(),
        specialInstructions: specialInstructions,
        paymentMethod: paymentMethod,
      );

      _orders.add(order);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure('Failed to place order: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String orderId) async {
    try {
      final order = _orders.firstWhere((o) => o.id == orderId);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure('Order not found'));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getOrderHistory() async {
    try {
      return Right(_orders);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch order history'));
    }
  }

  @override
  Future<Either<Failure, Order>> trackOrder(String orderId) async {
    try {
      final order = _orders.firstWhere((o) => o.id == orderId);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure('Order not found'));
    }
  }
}
