import 'package:freezed_annotation/freezed_annotation.dart';
import '/entities/menu_item.dart';

part 'menu_item_model.freezed.dart';
part 'menu_item_model.g.dart';

@freezed
class MenuItemModel with _$MenuItemModel {
  const factory MenuItemModel({
    required String id,
    required String restaurantId,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
    required String category,
    required bool isVegetarian,
    required bool isAvailable,
    required List<String> customizationOptions,
  }) = _MenuItemModel;

  factory MenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemModelFromJson(json);
}

extension MenuItemModelX on MenuItemModel {
  MenuItem toEntity() => MenuItem(
        id: id,
        restaurantId: restaurantId,
        name: name,
        description: description,
        imageUrl: imageUrl,
        price: price,
        category: category,
        isVegetarian: isVegetarian,
        isAvailable: isAvailable,
        customizationOptions: customizationOptions,
      );
}
