import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/price_breakdown_widget.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items from restaurants to get started',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Browse Restaurants'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (state.restaurant != null) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restaurant,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.restaurant!.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      '${state.restaurant!.deliveryTime} • \$${state.restaurant!.deliveryFee} delivery',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(duration: 600.ms),
                      const SizedBox(height: 16),
                    ],
                    ...state.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return CartItemWidget(
                        cartItem: item,
                        onQuantityChanged: (quantity) {
                          if (quantity == 0) {
                            context.read<CartBloc>().add(
                                  RemoveFromCart(item.menuItem.id),
                                );
                          } else {
                            context.read<CartBloc>().add(
                                  UpdateQuantity(item.menuItem.id, quantity),
                                );
                          }
                        },
                        onRemove: () {
                          context.read<CartBloc>().add(
                                RemoveFromCart(item.menuItem.id),
                              );
                        },
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 100 * index),
                            duration: 600.ms,
                          )
                          .slideX(begin: 0.1);
                    }).toList(),
                    const SizedBox(height: 16),
                    PriceBreakdownWidget(
                      subtotal: state.subtotal,
                      deliveryFee: state.deliveryFee,
                      tax: state.tax,
                      total: state.total,
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: state.restaurant?.minimumOrder != null &&
                            state.subtotal < state.restaurant!.minimumOrder
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckoutPage(),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: Text(
                      state.restaurant?.minimumOrder != null &&
                              state.subtotal < state.restaurant!.minimumOrder
                          ? 'Minimum order: \$${state.restaurant!.minimumOrder.toStringAsFixed(2)}'
                          : 'Proceed to Checkout',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
