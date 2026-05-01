import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/expense.dart';
import '../../notifiers/expense_notifier.dart';

class CreateExpenseScreen extends ConsumerStatefulWidget {
  const CreateExpenseScreen({super.key});

  @override
  ConsumerState<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends ConsumerState<CreateExpenseScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<ExpenseItem> _items = [ExpenseItem(title: '', amount: 0)];
  final List<String> _proofImages = [];

  void _addItem() {
    setState(() {
      _items.add(ExpenseItem(title: '', amount: 0));
    });
  }

  void _removeItem(int index) {
    if (_items.length > 1) {
      setState(() {
        _items.removeAt(index);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _proofImages.add(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Proof Image', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pickerOption(Iconsax.camera, 'Camera', () {
                  context.pop();
                  _pickImage(ImageSource.camera);
                }),
                _pickerOption(Iconsax.gallery, 'Gallery', () {
                  context.pop();
                  _pickImage(ImageSource.gallery);
                }),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _pickerOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.black),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }

  void _save() {
    // Validate all items have title and amount > 0
    if (_items.any((i) => i.title.isEmpty || i.amount <= 0)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter valid title and amount for all items')));
      return;
    }

    final newExpense = ExpenseModel(
      id: 'EXP${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      date: _selectedDate,
      items: _items,
      proofImages: _proofImages,
      status: ExpenseStatus.pending,
    );

    ref.read(expenseNotifierProvider.notifier).addExpense(newExpense);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Create Expense',
        subtitle: 'Add expenditure for the day',
        showBackButton: true,
        showDrawerButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('DATE SELECTION'),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) setState(() => _selectedDate = date);
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
                    Text(
                      DateFormat('dd MMMM, yyyy').format(_selectedDate),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    const Icon(Iconsax.edit_2, size: 16, color: AppColors.coolGrey),
                  ],
                ),
              ),
            ),
            AppGaps.largeV,
            
            _buildSectionTitle('EXPENDITURE SUMMARY'),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        onChanged: (val) => _items[index] = ExpenseItem(title: val, amount: _items[index].amount),
                        decoration: InputDecoration(
                          hintText: 'Description',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) => _items[index] = ExpenseItem(title: _items[index].title, amount: double.tryParse(val) ?? 0),
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          prefixText: '₹',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeItem(index),
                      icon: const Icon(Iconsax.minus_cirlce, color: Colors.red),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _addItem,
              icon: const Icon(Iconsax.add_circle, size: 20),
              label: const Text('Add Another Item', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
            AppGaps.largeV,
            
            _buildSectionTitle('ATTACH PROOFS'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ..._proofImages.map((path) => Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(image: FileImage(File(path)), fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () => setState(() => _proofImages.remove(path)),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 12),
                        ),
                      ),
                    ),
                  ],
                )),
                InkWell(
                  onTap: _showImagePickerOptions,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.coolGrey.withAlpha(30), style: BorderStyle.solid),
                    ),
                    child: const Icon(Iconsax.camera, color: AppColors.coolGrey),
                  ),
                ),
              ],
            ),
            
            AppGaps.extraLargeV,
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('SUBMIT EXPENSE CLAIM', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800)),
              ),
            ),
            AppGaps.extraLargeV,
          ],
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
}
