import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/models/menu_item_model.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:injectable/injectable.dart';
import '../errors/failures.dart';
import '../entities/restaurant.dart';
import '../../entities/menu_item.dart';
import '../../repositories/restaurant_repository.dart';
import '../data/mock_data_source.dart';

@LazySingleton(as: RestaurantRepository)
class RestaurantRepositoryImpl implements RestaurantRepository {
  final MockDataSource dataSource;

  RestaurantRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      final restaurants = await dataSource.getRestaurants();
      return Right(restaurants.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Restaurant>> getRestaurantById(String id) async {
    try {
      final restaurants = await dataSource.getRestaurants();
      final restaurant = restaurants.firstWhere((r) => r.id == id);
      return Right(restaurant.toEntity());
    } catch (e) {
      return Left(ServerFailure('Restaurant not found'));
    }
  }

  @override
  Future<Either<Failure, List<MenuItem>>> getMenuItems(
      String restaurantId) async {
    try {
      final items = await dataSource.getMenuItems(restaurantId);
      return Right(items.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurants(
      String query) async {
    try {
      final restaurants = await dataSource.getRestaurants();
      final filtered = restaurants.where((r) =>
          r.name.toLowerCase().contains(query.toLowerCase()) ||
          r.cuisine.toLowerCase().contains(query.toLowerCase()) ||
          r.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())));
      return Right(filtered.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
