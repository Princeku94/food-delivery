import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String category;
  final bool isVegetarian;
  final bool isAvailable;
  final List<String> customizationOptions;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.isVegetarian,
    required this.isAvailable,
    required this.customizationOptions,
  });

  @override
  List<Object> get props => [
        id,
        restaurantId,
        name,
        description,
        imageUrl,
        price,
        category,
        isVegetarian,
        isAvailable,
        customizationOptions,
      ];
}
