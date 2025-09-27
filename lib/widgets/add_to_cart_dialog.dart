import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../entities/menu_item.dart';

class AddToCartDialog extends StatefulWidget {
  final MenuItem menuItem;
  final Function(int quantity, List<String> customizations, String instructions)
      onAddToCart;

  const AddToCartDialog({
    super.key,
    required this.menuItem,
    required this.onAddToCart,
  });

  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  int _quantity = 1;
  final List<String> _selectedCustomizations = [];
  final _instructionsController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: widget.menuItem.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.menuItem.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ).animate().fadeIn(duration: 300.ms),
                    const SizedBox(height: 8),
                    Text(
                      widget.menuItem.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
                    const SizedBox(height: 16),
                    if (widget.menuItem.customizationOptions.isNotEmpty) ...[
                      Text(
                        'Customizations',
                        style: Theme.of(context).textTheme.titleMedium,
                      ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
                      const SizedBox(height: 8),
                      ...widget.menuItem.customizationOptions.map((option) {
                        return CheckboxListTile(
                          title: Text(option),
                          value: _selectedCustomizations.contains(option),
                          onChanged: (value) {
                            setState(() {
                              if (value ?? false) {
                                _selectedCustomizations.add(option);
                              } else {
                                _selectedCustomizations.remove(option);
                              }
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      'Special Instructions',
                      style: Theme.of(context).textTheme.titleMedium,
                    ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _instructionsController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Any special requests?',
                        border: OutlineInputBorder(),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              _quantity.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              onPressed: () => setState(() => _quantity++),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                        Text(
                          '\$${(widget.menuItem.price * _quantity).toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onAddToCart(
                                _quantity,
                                _selectedCustomizations,
                                _instructionsController.text,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
