import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  final String id;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String? apartment;
  final String? instructions;
  final double latitude;
  final double longitude;

  const DeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    this.apartment,
    this.instructions,
    required this.latitude,
    required this.longitude,
  });

  String get fullAddress {
    final parts = [street];
    if (apartment != null && apartment!.isNotEmpty) {
      parts.add('Apt $apartment');
    }
    parts.add('$city, $state $zipCode');
    return parts.join(', ');
  }

  @override
  List<Object?> get props => [
        id,
        street,
        city,
        state,
        zipCode,
        apartment,
        instructions,
        latitude,
        longitude,
      ];
}
