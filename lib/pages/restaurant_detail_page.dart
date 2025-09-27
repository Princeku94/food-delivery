import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../entities/restaurant.dart';
import '../../entities/menu_item.dart';
import '../bloc/menu_bloc.dart';
import '../bloc/restaurant_bloc.dart' hide LoadMenuItems;
import '../bloc/cart_bloc.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/shimmer_menu_item_card.dart';
import '../widgets/cart_bottom_bar.dart';
import 'cart_page.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final Map<String, List<MenuItem>> _categorizedItems = {};

  @override
  void initState() {
    super.initState();
    context.read<MenuBloc>().add(LoadMenuItems(widget.restaurant.id));
    context.read<CartBloc>().add(SetRestaurant(widget.restaurant));
  }

  @override
  void dispose() {
    context.read<MenuBloc>().add(ClearMenu());
    super.dispose();
  }

  void _categorizeItems(List<MenuItem> items) {
    _categorizedItems.clear();
    for (final item in items) {
      _categorizedItems.putIfAbsent(item.category, () => []).add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.restaurant.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ).animate().fadeIn(duration: 600.ms),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.restaurant.rating.toString(),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.restaurant.deliveryTime,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.delivery_dining,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '\$${widget.restaurant.deliveryFee.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: widget.restaurant.tags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                            ),
                          );
                        }).toList(),
                      ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    ],
                  ),
                ),
              ),
              BlocBuilder<MenuBloc, MenuState>(
                builder: (context, state) {
                  if (state is MenuLoading) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const ShimmerMenuItemCard(),
                          childCount: 5,
                        ),
                      ),
                    );
                  }

                  if (state is MenuLoaded) {
                    _categorizeItems(state.items);

                    return SliverPadding(
                      padding: const EdgeInsets.only(bottom: 100),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final category =
                                _categorizedItems.keys.elementAt(index);
                            final items = _categorizedItems[category]!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                ...items
                                    .map((item) => MenuItemCard(
                                          menuItem: item,
                                          onAddToCart: (quantity,
                                              customizations, instructions) {
                                            context.read<CartBloc>().add(
                                                  AddToCart(
                                                    item: item,
                                                    quantity: quantity,
                                                    customizations:
                                                        customizations,
                                                    specialInstructions:
                                                        instructions,
                                                  ),
                                                );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${item.name} added to cart'),
                                                duration:
                                                    const Duration(seconds: 2),
                                                action: SnackBarAction(
                                                  label: 'View Cart',
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            const CartPage(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ))
                                    .toList(),
                              ],
                            ).animate().fadeIn(
                                  delay: Duration(milliseconds: 100 * index),
                                  duration: 600.ms,
                                );
                          },
                          childCount: _categorizedItems.length,
                        ),
                      ),
                    );
                  }

                  if (state is MenuError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load menu',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MenuBloc>().add(
                                      LoadMenuItems(widget.restaurant.id),
                                    );
                              },
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SliverFillRemaining();
                },
              ),
            ],
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return const SizedBox.shrink();
              }

              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CartBottomBar(
                  itemCount: state.itemCount,
                  total: state.total,
                  onViewCart: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CartPage(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
