import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class ExpenseFilterCard extends StatelessWidget {
  final int selectedMonth;
  final int selectedYear;
  final Function(int, int) onFilterChanged;

  const ExpenseFilterCard({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final years = List.generate(5, (index) => DateTime.now().year - index);

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
          Text(
            'SELECT PERIOD',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildDropdown<int>(
                  context,
                  'Month',
                  Iconsax.calendar,
                  selectedMonth,
                  List.generate(12, (index) => index + 1),
                  (val) => onFilterChanged(val!, selectedYear),
                  (val) => months[val! - 1],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown<int>(
                  context,
                  'Year',
                  Iconsax.calendar_1,
                  selectedYear,
                  years,
                  (val) => onFilterChanged(selectedMonth, val!),
                  (val) => val.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(
    BuildContext context,
    String label,
    IconData icon,
    T value,
    List<T> items,
    Function(T?) onChanged,
    String Function(T?) labelMapper,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Iconsax.arrow_down_1, size: 16),
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.black),
                const SizedBox(width: 8),
                Text(labelMapper(item)),
              ],
            ),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
