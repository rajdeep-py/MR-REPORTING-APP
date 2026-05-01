import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/order.dart';
import '../../models/doctor.dart';
import '../../models/chemist_shop.dart';
import '../../models/visual_ads.dart';
import '../../notifiers/order_notifier.dart';
import '../../notifiers/doctor_notifier.dart';
import '../../notifiers/chemist_shop_notifier.dart';
import '../../notifiers/visual_ads_notifier.dart';
import '../../notifiers/stockist_notifier.dart';
import '../../models/stockist.dart';

class CreateOrderScreen extends ConsumerWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CreateOrderContent();
  }
}

class _CreateOrderContent extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CreateOrderContent> createState() => _CreateOrderContentState();
}

class _CreateOrderContentState extends ConsumerState<_CreateOrderContent> {
  final _formKey = GlobalKey<FormState>();
  DateTime _deliveryDate = DateTime.now().add(const Duration(days: 7));
  DoctorModel? _selectedDoctor;
  ChemistShopModel? _selectedShop;
  StockistModel? _selectedStockist;
  
  // List of items currently being added to the order
  final List<OrderItem> _tempItems = [];

  void _addItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddItemBottomSheet(
        onAdd: (item) => setState(() => _tempItems.add(item)),
      ),
    );
  }

  void _submit() {
    if (_selectedDoctor != null && _selectedShop != null && _selectedStockist != null && _tempItems.isNotEmpty) {
      final newOrder = OrderModel(
        id: 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        orderDate: DateTime.now(),
        deliveryDate: _deliveryDate,
        status: OrderStatus.pending,
        items: List.from(_tempItems),
        doctor: _selectedDoctor!,
        chemistShop: _selectedShop!,
        stockist: _selectedStockist!,
      );

      ref.read(orderNotifierProvider.notifier).addOrder(newOrder);
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select doctor, shop, stockist and add at least one product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctors = ref.watch(doctorNotifierProvider).allDoctors;
    final shops = ref.watch(chemistShopNotifierProvider).allShops;
    final stockists = ref.watch(stockistNotifierProvider).allStockists;
    final total = _tempItems.fold(0.0, (sum, item) => sum + item.total);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Create Order',
        subtitle: 'Log a new commercial request',
        showBackButton: true,
        showDrawerButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('STAKEHOLDERS'),
              _buildDoctorDropdown(doctors),
              AppGaps.mediumV,
              _buildShopDropdown(shops),
              AppGaps.mediumV,
              _buildStockistDropdown(stockists),
              AppGaps.largeV,
              
              _buildSectionTitle('EXPECTED DELIVERY'),
              _buildDatePicker(),
              AppGaps.largeV,
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle('PRODUCTS'),
                  TextButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Iconsax.add_circle, size: 18),
                    label: const Text('Add Item', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
              if (_tempItems.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.coolGrey.withAlpha(20)),
                  ),
                  child: const Center(child: Text('No products added yet.', style: TextStyle(color: AppColors.coolGrey))),
                )
              else
                ..._tempItems.asMap().entries.map((entry) => _buildItemCard(entry.value, entry.key)),
              
              AppGaps.extraLargeV,
              _buildTotalSummary(total),
              AppGaps.extraLargeV,
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('PLACE ORDER', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildDoctorDropdown(List<DoctorModel> doctors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DoctorModel>(
          isExpanded: true,
          hint: const Text('Select Ordering Doctor'),
          value: _selectedDoctor,
          items: doctors.map((d) => DropdownMenuItem(value: d, child: Text(d.name, style: const TextStyle(fontWeight: FontWeight.w700)))).toList(),
          onChanged: (val) => setState(() => _selectedDoctor = val),
        ),
      ),
    );
  }

  Widget _buildShopDropdown(List<ChemistShopModel> shops) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ChemistShopModel>(
          isExpanded: true,
          hint: const Text('Select Chemist Shop'),
          value: _selectedShop,
          items: shops.map((s) => DropdownMenuItem(value: s, child: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w700)))).toList(),
          onChanged: (val) => setState(() => _selectedShop = val),
        ),
      ),
    );
  }

  Widget _buildStockistDropdown(List<StockistModel> stockists) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<StockistModel>(
          isExpanded: true,
          hint: const Text('Select Stockist Incharge'),
          value: _selectedStockist,
          items: stockists.map((s) => DropdownMenuItem(value: s, child: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w700)))).toList(),
          onChanged: (val) => setState(() => _selectedStockist = val),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _deliveryDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 90)),
        );
        if (date != null) setState(() => _deliveryDate = date);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.calendar, color: AppColors.black),
            const SizedBox(width: 12),
            Text(DateFormat('dd MMMM, yyyy').format(_deliveryDate), style: const TextStyle(fontWeight: FontWeight.w700)),
            const Spacer(),
            const Icon(Iconsax.edit_2, size: 16, color: AppColors.coolGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(OrderItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.productName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                Text('Qty: ${item.quantity} × ₹${item.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, color: AppColors.coolGrey, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Text('₹${item.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => setState(() => _tempItems.removeAt(index)),
            icon: const Icon(Iconsax.trash, size: 18, color: Colors.red),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSummary(double total) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('ORDER TOTAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.5, fontSize: 12)),
          Text('₹${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
        ],
      ),
    );
  }
}

class _AddItemBottomSheet extends ConsumerStatefulWidget {
  final Function(OrderItem) onAdd;
  const _AddItemBottomSheet({required this.onAdd});

  @override
  ConsumerState<_AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends ConsumerState<_AddItemBottomSheet> {
  VisualAdModel? _selectedProduct;
  final _priceCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(visualAdsNotifierProvider).allAds;

    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ADD PRODUCT', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1)),
          const SizedBox(height: 24),
          _buildDropdown(products),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('Price', _priceCtrl, Iconsax.money, true)),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('Quantity', _qtyCtrl, Iconsax.box, true)),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedProduct != null && _priceCtrl.text.isNotEmpty && _qtyCtrl.text.isNotEmpty) {
                  widget.onAdd(OrderItem(
                    product: _selectedProduct!,
                    price: double.parse(_priceCtrl.text),
                    quantity: int.parse(_qtyCtrl.text),
                  ));
                  context.pop();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: const Text('ADD TO LIST', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(List<VisualAdModel> products) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<VisualAdModel>(
          isExpanded: true,
          hint: const Text('Select Product'),
          value: _selectedProduct,
          items: products.map((p) => DropdownMenuItem(value: p, child: Text(p.productName, style: const TextStyle(fontWeight: FontWeight.w700)))).toList(),
          onChanged: (val) => setState(() => _selectedProduct = val),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController ctrl, IconData icon, bool isNumber) {
    return TextField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}
