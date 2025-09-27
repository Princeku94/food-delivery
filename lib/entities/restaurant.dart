import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final String deliveryTime;
  final double deliveryFee;
  final double minimumOrder;
  final bool isOpen;
  final List<String> tags;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.isOpen,
    required this.tags,
  });

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
        rating,
        cuisine,
        deliveryTime,
        deliveryFee,
        minimumOrder,
        isOpen,
        tags,
      ];
}
