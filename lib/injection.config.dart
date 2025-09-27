// // dart format width=80
// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// // **************************************************************************
// // InjectableConfigGenerator
// // **************************************************************************
//
// // ignore_for_file: type=lint
// // coverage:ignore-file
//
// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'package:food_delivery_app/bloc/cart_bloc.dart' as _i744;
// import 'package:food_delivery_app/bloc/order_bloc.dart' as _i817;
// import 'package:food_delivery_app/bloc/restaurant_bloc.dart' as _i992;
// import 'package:food_delivery_app/data/mock_data_source.dart' as _i689;
// import 'package:food_delivery_app/repositories/order_repository.dart' as _i366;
// import 'package:food_delivery_app/repositories/order_repository_impl.dart'
//     as _i992;
// import 'package:food_delivery_app/repositories/restaurant_repository.dart'
//     as _i219;
// import 'package:food_delivery_app/repositories/restaurant_repository_impl.dart'
//     as _i367;
// import 'package:get_it/get_it.dart' as _i174;
// import 'package:injectable/injectable.dart' as _i526;
//
// extension GetItInjectableX on _i174.GetIt {
// // initializes the registration of main-scope dependencies inside of GetIt
//   _i174.GetIt init({
//     String? environment,
//     _i526.EnvironmentFilter? environmentFilter,
//   }) {
//     final gh = _i526.GetItHelper(
//       this,
//       environment,
//       environmentFilter,
//     );
//     gh.factory<_i744.CartBloc>(() => _i744.CartBloc());
//     gh.lazySingleton<_i689.MockDataSource>(() => _i689.MockDataSource());
//     gh.lazySingleton<_i366.OrderRepository>(() => _i992.OrderRepositoryImpl());
//     gh.lazySingleton<_i219.RestaurantRepository>(
//         () => _i367.RestaurantRepositoryImpl(gh<_i689.MockDataSource>()));
//     gh.factory<_i817.OrderBloc>(
//         () => _i817.OrderBloc(gh<_i366.OrderRepository>()));
//     gh.factory<_i992.RestaurantBloc>(
//         () => _i992.RestaurantBloc(gh<_i219.RestaurantRepository>()));
//     return this;
//   }
// }
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/mock_data_source.dart' as _i3;
import '/repositories/order_repository_impl.dart' as _i5;
import '/repositories/restaurant_repository_impl.dart' as _i7;
import '/repositories/order_repository.dart' as _i4;
import '/repositories/restaurant_repository.dart' as _i6;
import 'bloc/cart_bloc.dart' as _i8;
import 'bloc/menu_bloc.dart' as _i9;
import 'bloc/order_bloc.dart' as _i10;
import 'bloc/restaurant_bloc.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.MockDataSource>(() => _i3.MockDataSource());
    gh.lazySingleton<_i4.OrderRepository>(() => _i5.OrderRepositoryImpl());
    gh.lazySingleton<_i6.RestaurantRepository>(
        () => _i7.RestaurantRepositoryImpl(gh<_i3.MockDataSource>()));
    gh.factory<_i8.CartBloc>(() => _i8.CartBloc());
    gh.factory<_i9.MenuBloc>(
        () => _i9.MenuBloc(gh<_i6.RestaurantRepository>()));
    gh.factory<_i10.OrderBloc>(() => _i10.OrderBloc(gh<_i4.OrderRepository>()));
    gh.factory<_i11.RestaurantBloc>(
        () => _i11.RestaurantBloc(gh<_i6.RestaurantRepository>()));
    return this;
  }
}
