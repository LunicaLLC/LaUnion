import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:launionweb/providers/cart_provider.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../models/order.dart';
import '../../../providers/order_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/loyalty_provider.dart';
import '../../../ui/shared/app_button.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';
import '../../../utils/validators.dart';
import '../../layout/app_scaffold.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  int _currentStep = 0;
  DateTime _selectedPickupTime = DateTime.now().add(
    const Duration(minutes: 30),
  );
  bool _isASAP = true;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.card;
  bool _useLoyaltyPoints = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with user data if available
    final user = ref.read(authProvider);
    if (user != null) {
      _nameController.text = user.name ?? '';
      _phoneController.text = user.phone ?? '';
      _emailController.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final loyaltyState = ref.watch(loyaltyProvider);

    final subtotal = cartNotifier.subtotal;
    final tax = cartNotifier.tax;
    final total = cartNotifier.total;
    final itemCount = cartNotifier.itemCount;

    return AppScaffold(
      title: AppLocalizations.of(context)!.checkout,
      child: Stepper(
        currentStep: _currentStep,
        onStepContinue: _currentStep < 3 ? _goToNextStep : _placeOrder,
        onStepCancel: _currentStep > 0 ? _goToPreviousStep : null,
        onStepTapped: (step) {
          if (step < _currentStep) {
            setState(() => _currentStep = step);
          }
        },
        steps: [
          Step(
            title: Text(AppLocalizations.of(context)!.orderReview),
            subtitle: Text(AppLocalizations.of(context)!.itemCount(itemCount)),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: _buildOrderReview(cartItems, subtotal, tax, total),
          ),
          Step(
            title: Text(AppLocalizations.of(context)!.pickupTime),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: _buildPickupTimeStep(),
          ),
          Step(
            title: Text(AppLocalizations.of(context)!.customerInfo),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: _buildCustomerInfoStep(),
          ),
          Step(
            title: Text(AppLocalizations.of(context)!.payment),
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
            content: _buildPaymentStep(loyaltyState),
          ),
        ],
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                if (details.onStepCancel != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          details.onStepCancel!(), // Call with safety
                      child: Text(
                        _currentStep == 0
                            ? AppLocalizations.of(context)!.cancel
                            : AppLocalizations.of(context)!.back,
                      ),
                    ),
                  ),
                if (details.onStepCancel != null)
                  const SizedBox(width: AppConstants.md),
                Expanded(
                  child: AppButton(
                    text: _currentStep == 3
                        ? AppLocalizations.of(context)!.placeOrder
                        : AppLocalizations.of(context)!.continueStep,
                    onPressed:
                        details.onStepContinue ?? () {}, // Provide fallback
                    primary: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderReview(
    List<CartItem> cartItems,
    double subtotal,
    double tax,
    double total,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.yourOrder,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppConstants.md),
        ...cartItems.map((item) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.lightGrey,
              ),
            ),
            title: Text(item.menuItem.name),
            subtitle: Text(
              '${item.quantity}x • ${Formatters.formatCurrency(item.subtotal)}',
              style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Edit item
              },
            ),
          );
        }),
        const Divider(height: 32),
        _buildSummaryRow(AppLocalizations.of(context)!.subtotal, subtotal),
        _buildSummaryRow(AppLocalizations.of(context)!.tax, tax),
        const Divider(height: 16),
        _buildSummaryRow(
          AppLocalizations.of(context)!.total,
          total,
          isTotal: true,
        ),
        const SizedBox(height: AppConstants.lg),
        TextFormField(
          controller: _specialInstructionsController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.specialInstructions,
            hintText: AppLocalizations.of(context)!.specialInstructionsHint,
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPickupTimeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.pickupOptions,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppConstants.lg),
        RadioListTile<bool>(
          title: Text(AppLocalizations.of(context)!.asap),
          subtitle: Text(AppLocalizations.of(context)!.readyInMinutes),
          value: true,
          groupValue: _isASAP,
          onChanged: (value) => setState(() {
            _isASAP = value!;
          }),
        ),
        RadioListTile<bool>(
          title: Text(AppLocalizations.of(context)!.scheduleForLater),
          subtitle: Text(AppLocalizations.of(context)!.choosePickupTime),
          value: false,
          groupValue: _isASAP,
          onChanged: (value) => setState(() {
            _isASAP = value!;
          }),
        ),
        if (!_isASAP) ...[
          const SizedBox(height: AppConstants.lg),
          Text(
            AppLocalizations.of(context)!.selectPickupTime,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.md),
          ElevatedButton(
            onPressed: _selectPickupTime,
            child: Text(Formatters.formatDateTime(_selectedPickupTime)),
          ),
        ],
      ],
    );
  }

  Widget _buildCustomerInfoStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.contactInfo,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppConstants.lg),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.fullName,
              border: const OutlineInputBorder(),
            ),
            validator: Validators.validateName,
          ),
          const SizedBox(height: AppConstants.md),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: AppConstants.md),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.emailOptional,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return null;
              return Validators.validateEmail(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep(LoyaltyState loyaltyState) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final total = cartNotifier.total;
    final loyaltyDiscount = _useLoyaltyPoints && loyaltyState.points >= 1000
        ? 5.0
        : 0.0;
    final finalTotal = total - loyaltyDiscount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.paymentMethod,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppConstants.lg),
        ...PaymentMethod.values.map((method) {
          return RadioListTile<PaymentMethod>(
            title: Text(_getPaymentMethodName(context, method)),
            subtitle: method == PaymentMethod.cash
                ? Text(AppLocalizations.of(context)!.payWhenPickup)
                : null,
            value: method,
            groupValue: _selectedPaymentMethod,
            onChanged: (value) => setState(() {
              _selectedPaymentMethod = value!;
            }),
          );
        }),
        const SizedBox(height: AppConstants.lg),
        if (loyaltyState.points >= 1000) ...[
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _useLoyaltyPoints,
                      onChanged: (value) => setState(() {
                        _useLoyaltyPoints = value!;
                      }),
                    ),
                    Text(
                      AppLocalizations.of(context)!.useLoyaltyPoints,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                if (_useLoyaltyPoints) ...[
                  const SizedBox(height: AppConstants.md),
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.pointsAvailable(loyaltyState.points),
                    style: const TextStyle(color: AppTheme.avocadoGreen),
                  ),
                  const SizedBox(height: AppConstants.sm),
                  Text(
                    AppLocalizations.of(context)!.redeemPoints,
                    style: TextStyle(color: AppTheme.charcoal.withOpacity(0.6)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppConstants.lg),
        ],
        Text(
          AppLocalizations.of(context)!.orderSummary,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.md),
        _buildSummaryRow(
          AppLocalizations.of(context)!.subtotal,
          cartNotifier.subtotal,
        ),
        _buildSummaryRow(AppLocalizations.of(context)!.tax, cartNotifier.tax),
        if (loyaltyDiscount > 0)
          _buildSummaryRow(
            AppLocalizations.of(context)!.loyaltyDiscount,
            -loyaltyDiscount,
          ),
        const Divider(height: 16),
        _buildSummaryRow(
          AppLocalizations.of(context)!.total,
          finalTotal,
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal
                  ? AppTheme.charcoal
                  : AppTheme.charcoal.withOpacity(0.6),
            ),
          ),
          Text(
            Formatters.formatCurrency(amount),
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: isTotal ? AppTheme.spicyRed : AppTheme.charcoal,
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodName(BuildContext context, PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return AppLocalizations.of(context)!.methodCard;
      case PaymentMethod.cash:
        return AppLocalizations.of(context)!.methodCash;
      case PaymentMethod.applePay:
        return AppLocalizations.of(context)!.methodApplePay;
      case PaymentMethod.googlePay:
        return AppLocalizations.of(context)!.methodGooglePay;
    }
  }

  void _goToNextStep() {
    if (_currentStep == 2) {
      if (!_formKey.currentState!.validate()) return;
    }

    setState(() => _currentStep++);
  }

  void _goToPreviousStep() {
    setState(() => _currentStep--);
  }

  Future<void> _selectPickupTime() async {
    final now = DateTime.now();
    final initialTime = _selectedPickupTime;

    final date = await showDatePicker(
      context: context,
      initialDate: initialTime,
      firstDate: now,
      lastDate: now.add(const Duration(days: 7)),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialTime),
      );

      if (time != null) {
        setState(() {
          _selectedPickupTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _placeOrder() async {
    try {
      // Get user
      final user = ref.read(authProvider);
      final cartNotifier = ref.read(cartProvider.notifier);
      final orderNotifier = ref.read(orderProvider.notifier);

      // Create order
      final order = Order(
        id: '',
        userId: user?.id ?? 'guest',
        status: OrderStatus.received,
        total: cartNotifier.total,
        pickupTime: _isASAP
            ? DateTime.now().add(const Duration(minutes: 20))
            : _selectedPickupTime,
        paymentMethod: _selectedPaymentMethod,
        createdAt: DateTime.now(),
        items: cartNotifier.toOrderItems(),
      );

      // Create order in backend
      final createdOrder = await orderNotifier.createOrder(order);

      // Clear cart
      cartNotifier.clearCart();

      // Navigate to confirmation
      context.go('/orders/${createdOrder.id}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.placeOrderFailed(e.toString()),
          ),
          backgroundColor: AppTheme.spicyRed,
        ),
      );
    }
  }
}
