// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_delivery_app/pages/restaurant_list_page.dart';
// import 'package:food_delivery_app/utils/app_theme.dart';
// import 'package:get_it/get_it.dart';
//
// import 'bloc/cart_bloc.dart';
// import 'bloc/order_bloc.dart';
// import 'bloc/restaurant_bloc.dart';
// import 'injection.dart';
//
// final getIt = GetIt.instance;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );
//
//   await configureDependencies();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => getIt<RestaurantBloc>()),
//         BlocProvider(create: (_) => getIt<CartBloc>()),
//         BlocProvider(create: (_) => getIt<OrderBloc>()),
//       ],
//       child: MaterialApp(
//         title: 'Food Delivery',
//         theme: AppTheme.lightTheme,
//         debugShowCheckedModeBanner: false,
//         home: const RestaurantListPage(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/pages/restaurant_list_page.dart';
import 'package:food_delivery_app/utils/app_theme.dart';
import 'package:get_it/get_it.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/menu_bloc.dart';
import 'bloc/order_bloc.dart';
import 'bloc/restaurant_bloc.dart';
import 'injection.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<RestaurantBloc>()),
        BlocProvider(create: (_) => getIt<MenuBloc>()),
        BlocProvider(create: (_) => getIt<CartBloc>()),
        BlocProvider(create: (_) => getIt<OrderBloc>()),
      ],
      child: MaterialApp(
        title: 'Food Delivery',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const RestaurantListPage(),
      ),
    );
  }
}
