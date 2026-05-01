import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../models/chemist_shop_reporting.dart';

class ChemistShopReportingFilterCard extends StatelessWidget {
  final String? selectedStatus;
  final DateTime? selectedDate;
  final Function(String?) onStatusChanged;
  final Function(DateTime?) onDateChanged;

  const ChemistShopReportingFilterCard({
    super.key,
    this.selectedStatus,
    this.selectedDate,
    required this.onStatusChanged,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'FILTERS',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              if (selectedStatus != null || selectedDate != null)
                TextButton(
                  onPressed: () {
                    onStatusChanged(null);
                    onDateChanged(null);
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: ChemistReportingStatus.values.map((status) {
                final isSelected = selectedStatus == status.name;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(status.name.toUpperCase()),
                    selected: isSelected,
                    onSelected: (val) => onStatusChanged(val ? status.name : null),
                    selectedColor: AppColors.black,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: InkWell(
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
                    const Icon(
                      Iconsax.calendar_1,
                      size: 18,
                      color: AppColors.black,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate == null
                          ? 'Filter by Date'
                          : DateFormat('dd MMM, yyyy').format(selectedDate!),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
