import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class DoctorSearchFilterCard extends StatelessWidget {
  final Function(String) onSearch;
  final Function(String?) onFilter;
  final List<String> specializations;
  final String? selectedSpecialization;

  const DoctorSearchFilterCard({
    super.key,
    required this.onSearch,
    required this.onFilter,
    required this.specializations,
    this.selectedSpecialization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        children: [
          TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: 'Search by doctor name...',
              prefixIcon: const Icon(Iconsax.search_normal, color: AppColors.coolGrey),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip(context, 'All', null),
                ...specializations.map((s) => _filterChip(context, s, s)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(BuildContext context, String label, String? value) {
    final bool isSelected = selectedSpecialization == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => onFilter(value),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.black : AppColors.coolGrey.withAlpha(50),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
