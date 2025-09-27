import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart' hide Order;
import '../../../entities/order.dart';
import '../../../entities/cart_item.dart';
import '../../../entities/delivery_address.dart';
import '../../../repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
    on<TrackOrder>(_onTrackOrder);
    on<LoadOrderHistory>(_onLoadOrderHistory);
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await repository.placeOrder(
      restaurantId: event.restaurantId,
      items: event.items,
      deliveryAddress: event.deliveryAddress,
      paymentMethod: event.paymentMethod,
      specialInstructions: event.specialInstructions,
    );

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderPlaced(order)),
    );
  }

  Future<void> _onTrackOrder(
    TrackOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await repository.trackOrder(event.orderId);

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderTracking(order)),
    );
  }

  Future<void> _onLoadOrderHistory(
    LoadOrderHistory event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await repository.getOrderHistory();

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrderHistoryLoaded(orders)),
    );
  }
}
