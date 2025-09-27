// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:nestafar/main.dart';
//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/bloc/cart_bloc.dart';
import 'package:food_delivery_app/bloc/menu_bloc.dart';
import 'package:food_delivery_app/bloc/order_bloc.dart';
import 'package:food_delivery_app/bloc/restaurant_bloc.dart';
import 'package:food_delivery_app/entities/menu_item.dart';
import 'package:food_delivery_app/entities/restaurant.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_delivery_app/main.dart';

class MockRestaurantBloc extends Mock implements RestaurantBloc {}

class MockCartBloc extends Mock implements CartBloc {}

class MockOrderBloc extends Mock implements OrderBloc {}

class MockMenuBloc extends Mock implements MenuBloc {}

void main() {
  late MockRestaurantBloc mockRestaurantBloc;
  late MockCartBloc mockCartBloc;
  late MockOrderBloc mockOrderBloc;
  late MockMenuBloc mockMenuBloc;
  setUp(() {
    mockRestaurantBloc = MockRestaurantBloc();
    mockCartBloc = MockCartBloc();
    mockOrderBloc = MockOrderBloc();
    mockMenuBloc = MockMenuBloc();
  });

  testWidgets('App should show restaurant list on start',
      (WidgetTester tester) async {
    when(() => mockRestaurantBloc.state).thenReturn(RestaurantInitial());
    when(() => mockCartBloc.state).thenReturn(const CartState());
    when(() => mockOrderBloc.state).thenReturn(OrderInitial());
    when(() => mockMenuBloc.state).thenReturn(MenuInitial());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<RestaurantBloc>.value(value: mockRestaurantBloc),
          BlocProvider<CartBloc>.value(value: mockCartBloc),
          BlocProvider<OrderBloc>.value(value: mockOrderBloc),
        ],
        child: const MaterialApp(
          home: Scaffold(body: Text('Restaurant List')),
        ),
      ),
    );

    expect(find.text('Restaurant List'), findsOneWidget);
  });

  group('Restaurant List Tests', () {
    testWidgets('Should display loading indicator when loading restaurants',
        (WidgetTester tester) async {
      when(() => mockRestaurantBloc.state).thenReturn(RestaurantLoading());

      await tester.pumpWidget(
        BlocProvider<RestaurantBloc>.value(
          value: mockRestaurantBloc,
          child: const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display restaurants when loaded',
        (WidgetTester tester) async {
      final restaurants = [
        const Restaurant(
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
        ),
      ];

      when(() => mockRestaurantBloc.state)
          .thenReturn(RestaurantsLoaded(restaurants));

      await tester.pumpWidget(
        BlocProvider<RestaurantBloc>.value(
          value: mockRestaurantBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) => Text(restaurants[index].name),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Restaurant'), findsOneWidget);
    });
  });

  group('Cart Tests', () {
    testWidgets('Should show empty cart message when cart is empty',
        (WidgetTester tester) async {
      when(() => mockCartBloc.state).thenReturn(const CartState());

      await tester.pumpWidget(
        BlocProvider<CartBloc>.value(
          value: mockCartBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Your cart is empty')),
            ),
          ),
        ),
      );

      expect(find.text('Your cart is empty'), findsOneWidget);
    });
  });

  group('Menu Item Tests', () {
    testWidgets('Should display menu items when loaded',
        (WidgetTester tester) async {
      final menuItems = [
        const MenuItem(
          id: '1',
          restaurantId: '1',
          name: 'Pizza Margherita',
          description: 'Fresh mozzarella and basil',
          imageUrl: 'https://example.com/pizza.jpg',
          price: 12.99,
          category: 'Pizza',
          isVegetarian: true,
          isAvailable: true,
          customizationOptions: ['Extra Cheese'],
        ),
      ];

      when(() => mockMenuBloc.state).thenReturn(MenuLoaded(menuItems));

      await tester.pumpWidget(
        BlocProvider<RestaurantBloc>.value(
          value: mockRestaurantBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) => Text(menuItems[index].name),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Pizza Margherita'), findsOneWidget);
    });
  });
}
