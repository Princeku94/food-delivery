import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../entities/delivery_address.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/order_bloc.dart';
import '../widgets/address_form_widget.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/order_summary_widget.dart';
import 'order_tracking_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  String _selectedPaymentMethod = 'Credit Card';

  @override
  void dispose() {
    _streetController.dispose();
    _apartmentController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _instructionsController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      final cartState = context.read<CartBloc>().state;
      final deliveryAddress = DeliveryAddress(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        street: _streetController.text,
        apartment: _apartmentController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipCodeController.text,
        instructions: _instructionsController.text,
        latitude: 37.7749,
        longitude: -122.4194,
      );

      context.read<OrderBloc>().add(
            PlaceOrder(
              restaurantId: cartState.restaurant!.id,
              items: cartState.items,
              deliveryAddress: deliveryAddress,
              paymentMethod: _selectedPaymentMethod,
              specialInstructions: _specialInstructionsController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderPlaced) {
            context.read<CartBloc>().add(ClearCart());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => OrderTrackingPage(order: state.order),
              ),
            );
          } else if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Delivery Address',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              AddressFormWidget(
                streetController: _streetController,
                apartmentController: _apartmentController,
                cityController: _cityController,
                stateController: _stateController,
                zipCodeController: _zipCodeController,
                instructionsController: _instructionsController,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 24),
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              const SizedBox(height: 16),
              PaymentMethodWidget(
                selectedMethod: _selectedPaymentMethod,
                onMethodSelected: (method) {
                  setState(() {
                    _selectedPaymentMethod = method;
                  });
                },
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
              const SizedBox(height: 24),
              Text(
                'Special Instructions',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialInstructionsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Any special requests for your order?',
                  border: OutlineInputBorder(),
                ),
              ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
              const SizedBox(height: 24),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return OrderSummaryWidget(
                    items: state.items,
                    subtotal: state.subtotal,
                    deliveryFee: state.deliveryFee,
                    tax: state.tax,
                    total: state.total,
                  ).animate().fadeIn(delay: 1200.ms, duration: 600.ms);
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is OrderLoading ? null : _placeOrder,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: state is OrderLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ).animate().fadeIn(delay: 1400.ms, duration: 600.ms);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
