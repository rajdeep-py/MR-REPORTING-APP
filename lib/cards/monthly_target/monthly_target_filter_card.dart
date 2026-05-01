import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class MonthlyTargetFilterCard extends StatelessWidget {
  final int selectedMonth;
  final int selectedYear;
  final Function(int) onMonthChanged;
  final Function(int) onYearChanged;

  const MonthlyTargetFilterCard({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final years = List.generate(5, (index) => 2024 + index);

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
            'PERIOD SELECTION',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildDropdown(context, months, selectedMonth - 1, (idx) => onMonthChanged(idx + 1))),
              const SizedBox(width: 12),
              Expanded(child: _buildDropdown(context, years.map((y) => y.toString()).toList(), years.indexOf(selectedYear), (idx) => onYearChanged(years[idx]))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, List<String> items, int selectedIndex, Function(int) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: selectedIndex >= 0 ? selectedIndex : 0,
          icon: const Icon(Iconsax.arrow_down_1, size: 16),
          items: List.generate(items.length, (index) => DropdownMenuItem(
            value: index,
            child: Text(items[index], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          )),
          onChanged: (val) => onChanged(val!),
        ),
      ),
    );
  }
}
