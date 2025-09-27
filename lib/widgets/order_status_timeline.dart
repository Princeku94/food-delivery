import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../entities/order.dart';

class OrderStatusTimeline extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusTimeline({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'status': OrderStatus.pending,
        'label': 'Order Placed',
        'icon': Icons.receipt
      },
      {
        'status': OrderStatus.confirmed,
        'label': 'Confirmed',
        'icon': Icons.check_circle
      },
      {
        'status': OrderStatus.preparing,
        'label': 'Preparing',
        'icon': Icons.restaurant
      },
      {
        'status': OrderStatus.onTheWay,
        'label': 'On the Way',
        'icon': Icons.delivery_dining
      },
      {
        'status': OrderStatus.delivered,
        'label': 'Delivered',
        'icon': Icons.home
      },
    ];

    final currentIndex = steps.indexWhere((step) => step['status'] == status);

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isCompleted = index <= currentIndex;
        final isActive = index == currentIndex;

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step['icon'] as IconData,
                    color: Colors.white,
                    size: 20,
                  ),
                )
                    .animate(
                      delay: Duration(milliseconds: index * 200),
                    )
                    .scale(
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    ),
                if (index < steps.length - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: isCompleted
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['label'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isCompleted ? null : Colors.grey,
                          fontWeight: isActive ? FontWeight.bold : null,
                        ),
                  ),
                  if (isActive)
                    Text(
                      'Current Status',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        )
            .animate(
              delay: Duration(milliseconds: index * 200),
            )
            .fadeIn(duration: 600.ms)
            .slideX(begin: 0.2);
      }),
    );
  }
}
