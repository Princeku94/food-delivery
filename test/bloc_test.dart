import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' hide Order;

import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/bloc/cart_bloc.dart';
import 'package:food_delivery_app/bloc/order_bloc.dart';
import 'package:food_delivery_app/bloc/restaurant_bloc.dart';
import 'package:food_delivery_app/entities/cart_item.dart';
import 'package:food_delivery_app/entities/delivery_address.dart';
import 'package:food_delivery_app/entities/menu_item.dart';
import 'package:food_delivery_app/entities/order.dart';
import 'package:food_delivery_app/entities/restaurant.dart';
import 'package:food_delivery_app/errors/failures.dart';
import 'package:food_delivery_app/repositories/order_repository.dart';
import 'package:food_delivery_app/repositories/restaurant_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late MockRestaurantRepository mockRestaurantRepository;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    mockOrderRepository = MockOrderRepository();
  });

  group('RestaurantBloc', () {
    const testRestaurant = Restaurant(
      id: '1',
      name: 'Test Restaurant',
      imageUrl: 'https://example.com/image.jpg',
      rating: 4.5,
      cuisine: 'Italian',
      deliveryTime: '30-40 min',
      deliveryFee: 2.99,
      minimumOrder: 15.0,
      isOpen: true,
      tags: ['Italian', 'Pizza'],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantsLoaded] when LoadRestaurants is successful',
      build: () {
        when(() => mockRestaurantRepository.getRestaurants())
            .thenAnswer((_) async => const Right([testRestaurant]));
        return RestaurantBloc(mockRestaurantRepository);
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantLoading(),
        const RestaurantsLoaded([testRestaurant]),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantError] when LoadRestaurants fails',
      build: () {
        when(() => mockRestaurantRepository.getRestaurants())
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return RestaurantBloc(mockRestaurantRepository);
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantLoading(),
        const RestaurantError('Server error'),
      ],
    );
  });

  group('CartBloc', () {
    const testMenuItem = MenuItem(
      id: '1',
      restaurantId: '1',
      name: 'Pizza',
      description: 'Delicious pizza',
      imageUrl: 'https://example.com/pizza.jpg',
      price: 12.99,
      category: 'Main',
      isVegetarian: true,
      isAvailable: true,
      customizationOptions: [],
    );

    blocTest<CartBloc, CartState>(
      'emits updated state when AddToCart is called',
      build: () => CartBloc(),
      act: (bloc) => bloc.add(const AddToCart(
        item: testMenuItem,
        quantity: 2,
      )),
      expect: () => [
        CartState(
          items: [
            const CartItem(
              menuItem: testMenuItem,
              quantity: 2,
            ),
          ],
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits empty state when ClearCart is called',
      build: () => CartBloc(),
      seed: () => CartState(
        items: [
          const CartItem(
            menuItem: testMenuItem,
            quantity: 1,
          ),
        ],
      ),
      act: (bloc) => bloc.add(ClearCart()),
      expect: () => [const CartState()],
    );
  });

  group('OrderBloc', () {
    final testDeliveryAddress = DeliveryAddress(
      id: '1',
      street: '123 Main St',
      city: 'Test City',
      state: 'TS',
      zipCode: '12345',
      latitude: 0.0,
      longitude: 0.0,
    );
    final testOrder = Order(
      id: '1',
      restaurantId: '1',
      items: const [],
      deliveryAddress: testDeliveryAddress,
      subtotal: 25.98,
      deliveryFee: 2.99,
      tax: 2.08,
      total: 31.05,
      status: OrderStatus.confirmed,
      createdAt: DateTime.now(),
      paymentMethod: 'Credit Card',
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderPlaced] when PlaceOrder is successful',
      build: () {
        when(() => mockOrderRepository.placeOrder(
              restaurantId: any(named: 'restaurantId'),
              items: any(named: 'items'),
              deliveryAddress: any(named: 'deliveryAddress'),
              paymentMethod: any(named: 'paymentMethod'),
              specialInstructions: any(named: 'specialInstructions'),
            )).thenAnswer((_) async => Right(testOrder));
        return OrderBloc(mockOrderRepository);
      },
      act: (bloc) => bloc.add(PlaceOrder(
        restaurantId: '1',
        items: const [],
        deliveryAddress: testDeliveryAddress,
        paymentMethod: 'Credit Card',
      )),
      expect: () => [
        OrderLoading(),
        OrderPlaced(testOrder),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderError] when PlaceOrder fails',
      build: () {
        when(() => mockOrderRepository.placeOrder(
                  restaurantId: any(named: 'restaurantId'),
                  items: any(named: 'items'),
                  deliveryAddress: any(named: 'deliveryAddress'),
                  paymentMethod: any(named: 'paymentMethod'),
                  specialInstructions: any(named: 'specialInstructions'),
                ))
            .thenAnswer((_) async =>
                const Left(ServerFailure('Failed to place order')));
        return OrderBloc(mockOrderRepository);
      },
      act: (bloc) => bloc.add(PlaceOrder(
        restaurantId: '1',
        items: const [],
        deliveryAddress: testDeliveryAddress,
        paymentMethod: 'Credit Card',
      )),
      expect: () => [
        OrderLoading(),
        const OrderError('Failed to place order'),
      ],
    );
  });
}
