import 'package:flutter/material.dart';

class AddressFormWidget extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController apartmentController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
  final TextEditingController instructionsController;

  const AddressFormWidget({
    super.key,
    required this.streetController,
    required this.apartmentController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
    required this.instructionsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: streetController,
          decoration: const InputDecoration(
            labelText: 'Street Address',
            prefixIcon: Icon(Icons.location_on),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter street address';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: apartmentController,
          decoration: const InputDecoration(
            labelText: 'Apartment/Suite (Optional)',
            prefixIcon: Icon(Icons.home),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter state';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: zipCodeController,
          decoration: const InputDecoration(
            labelText: 'ZIP Code',
            prefixIcon: Icon(Icons.pin_drop),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ZIP code';
            }
            if (value.length != 5) {
              return 'ZIP code must be 5 digits';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: instructionsController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Delivery Instructions (Optional)',
            hintText: 'Gate code, building entrance, etc.',
            prefixIcon: Icon(Icons.info_outline),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
