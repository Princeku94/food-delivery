import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DeliveryMapWidget extends StatelessWidget {
  const DeliveryMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          // Placeholder for map
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 8),
                Text(
                  'Live tracking coming soon',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Animated delivery icon
          Positioned(
            top: 80,
            left: 50,
            child: Icon(
              Icons.delivery_dining,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .moveX(
                  begin: 0,
                  end: 200,
                  duration: 3.seconds,
                  curve: Curves.easeInOut,
                ),
          ),
        ],
      ),
    );
  }
}
