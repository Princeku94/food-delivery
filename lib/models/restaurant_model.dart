import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/restaurant.dart';
part 'restaurant_model.freezed.dart';
part 'restaurant_model.g.dart';

@freezed
class RestaurantModel with _$RestaurantModel {
  const factory RestaurantModel({
    required String id,
    required String name,
    required String imageUrl,
    required double rating,
    required String cuisine,
    required String deliveryTime,
    required double deliveryFee,
    required double minimumOrder,
    required bool isOpen,
    required List<String> tags,
  }) = _RestaurantModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}

extension RestaurantModelX on RestaurantModel {
  Restaurant toEntity() => Restaurant(
        id: id,
        name: name,
        imageUrl: imageUrl,
        rating: rating,
        cuisine: cuisine,
        deliveryTime: deliveryTime,
        deliveryFee: deliveryFee,
        minimumOrder: minimumOrder,
        isOpen: isOpen,
        tags: tags,
      );
}
