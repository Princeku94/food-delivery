import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../entities/restaurant.dart';
import '../entities/menu_item.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurants();
  Future<Either<Failure, Restaurant>> getRestaurantById(String id);
  Future<Either<Failure, List<MenuItem>>> getMenuItems(String restaurantId);
  Future<Either<Failure, List<Restaurant>>> searchRestaurants(String query);
}
