import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/gift.dart';
import '../../models/doctor.dart';
import '../../notifiers/gift_notifier.dart';
import '../../notifiers/doctor_notifier.dart';

class RequestGiftScreen extends ConsumerStatefulWidget {
  const RequestGiftScreen({super.key});

  @override
  ConsumerState<RequestGiftScreen> createState() => _RequestGiftScreenState();
}

class _RequestGiftScreenState extends ConsumerState<RequestGiftScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  DoctorModel? _selectedDoctor;
  String? _selectedOccasion;
  String? _selectedGiftItem;

  final List<String> _occasions = [
    'Birthday',
    'Anniversary',
    'Festival',
    'Clinic Inauguration',
    'Others'
  ];

  final List<String> _giftItems = [
    'Medical Equipment',
    'Diary & Pen Set',
    'Wall Clock',
    'Table Lamp',
    'Customized Memento',
    'Reference Book'
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDoctor != null && _selectedOccasion != null && _selectedGiftItem != null) {
      final newGift = GiftModel(
        id: 'REQ${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        doctor: _selectedDoctor!,
        occasion: _selectedOccasion!,
        giftItem: _selectedGiftItem!,
        date: DateFormat('yyyy-MM-dd').format(_selectedDate),
        status: GiftStatus.pending,
      );

      ref.read(giftNotifierProvider.notifier).addGift(newGift);
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gift request submitted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctors = ref.watch(doctorNotifierProvider).allDoctors;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Request Gift',
        subtitle: 'Fill details for doctor rewards',
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
              _buildSectionTitle('SELECT DOCTOR'),
              _buildDoctorDropdown(doctors),
              AppGaps.largeV,
              
              _buildSectionTitle('DATE SELECTION'),
              _buildDatePicker(),
              AppGaps.largeV,
              
              _buildSectionTitle('OCCASION'),
              _buildStringDropdown('Select Occasion', _selectedOccasion, _occasions, (v) => setState(() => _selectedOccasion = v)),
              AppGaps.largeV,
              
              _buildSectionTitle('GIFT ITEM'),
              _buildStringDropdown('Select Gift Item', _selectedGiftItem, _giftItems, (v) => setState(() => _selectedGiftItem = v)),
              
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
                  child: const Text(
                    'SUBMIT REQUEST',
                    style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800, letterSpacing: 1),
                  ),
                ),
              ),
              AppGaps.extraLargeV,
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
          hint: const Text('Select a Doctor'),
          value: _selectedDoctor,
          items: doctors.map((d) => DropdownMenuItem(
            value: d,
            child: Text(d.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          )).toList(),
          onChanged: (val) => setState(() => _selectedDoctor = val),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
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
    );
  }

  Widget _buildStringDropdown(String hint, String? value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint),
          value: value,
          items: items.map((i) => DropdownMenuItem(
            value: i,
            child: Text(i, style: const TextStyle(fontWeight: FontWeight.w600)),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
