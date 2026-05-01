import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../notifiers/doctor_notifier.dart';
import '../../models/doctor.dart';

class GiftFilterCard extends ConsumerWidget {
  final String? selectedDoctorId;
  final DateTime? selectedDate;
  final Function(String?) onDoctorChanged;
  final Function(DateTime?) onDateChanged;

  const GiftFilterCard({
    super.key,
    this.selectedDoctorId,
    this.selectedDate,
    required this.onDoctorChanged,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctors = ref.watch(doctorNotifierProvider).allDoctors;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FILTERS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
              ),
              if (selectedDoctorId != null || selectedDate != null)
                TextButton(
                  onPressed: () {
                    onDoctorChanged(null);
                    onDateChanged(null);
                  },
                  child: const Text('Clear All', style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDoctorDropdown(context, doctors),
          const SizedBox(height: 12),
          _buildDatePicker(context),
        ],
      ),
    );
  }

  Widget _buildDoctorDropdown(BuildContext context, List<DoctorModel> doctors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Filter by Doctor', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          value: selectedDoctorId,
          icon: const Icon(Iconsax.arrow_down_1, size: 16),
          items: doctors.map((d) => DropdownMenuItem(
            value: d.id,
            child: Text(d.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          )).toList(),
          onChanged: onDoctorChanged,
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        onDateChanged(date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.calendar_1, size: 18, color: AppColors.black),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? 'Filter by Date'
                  : DateFormat('dd MMM, yyyy').format(selectedDate!),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const Spacer(),
            if (selectedDate != null)
              IconButton(
                onPressed: () => onDateChanged(null),
                icon: const Icon(Iconsax.close_circle, size: 16),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }
}
