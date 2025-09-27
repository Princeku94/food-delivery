import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../bloc/restaurant_bloc.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/shimmer_restaurant_card.dart';
import 'restaurant_detail_page.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  void initState() {
    super.initState();
    // Only load if we don't have restaurants already
    final state = context.read<RestaurantBloc>().state;
    if (state is! RestaurantsLoaded) {
      context.read<RestaurantBloc>().add(const LoadRestaurants());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context
                .read<RestaurantBloc>()
                .add(const LoadRestaurants(forceReload: true));
            // Wait for the state to update
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good ${_getGreeting()}!',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms)
                                  .slideX(begin: -0.2),
                              const SizedBox(height: 8),
                              Text(
                                'What would you like to eat today?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                    ),
                              )
                                  .animate()
                                  .fadeIn(delay: 200.ms, duration: 600.ms),
                            ],
                          ),
                          const CartIconButton()
                              .animate()
                              .fadeIn(delay: 400.ms, duration: 600.ms),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SearchBarWidget(
                        onSearch: (query) {
                          context
                              .read<RestaurantBloc>()
                              .add(SearchRestaurants(query));
                        },
                      ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    ],
                  ),
                ),
              ),
              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoading) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => const ShimmerRestaurantCard(),
                          childCount: 5,
                        ),
                      ),
                    );
                  }

                  if (state is RestaurantsLoaded) {
                    if (state.restaurants.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant_outlined,
                                size: 64,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No restaurants found',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try searching for something else',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final restaurant = state.restaurants[index];
                            return RestaurantCard(
                              restaurant: restaurant,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RestaurantDetailPage(
                                      restaurant: restaurant,
                                    ),
                                  ),
                                );
                                // No need to reload, state is preserved
                              },
                            )
                                .animate()
                                .fadeIn(
                                  delay: Duration(milliseconds: 100 * index),
                                  duration: 600.ms,
                                )
                                .slideY(begin: 0.1);
                          },
                          childCount: state.restaurants.length,
                        ),
                      ),
                    );
                  }

                  if (state is RestaurantError) {
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
                              'Something went wrong',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<RestaurantBloc>()
                                    .add(const LoadRestaurants());
                              },
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}
