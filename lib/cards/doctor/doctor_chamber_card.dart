import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../models/doctor.dart';

class DoctorChamberCard extends StatelessWidget {
  final List<DoctorChamber> chambers;

  const DoctorChamberCard({super.key, required this.chambers});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CHAMBER DETAILS',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chambers.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, thickness: 0.5),
            ),
            itemBuilder: (context, index) {
              final chamber = chambers[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.hospital, color: AppColors.black, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        chamber.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildSubInfo(Iconsax.location, chamber.address),
                  const SizedBox(height: 4),
                  _buildSubInfo(Iconsax.call, chamber.phone),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.coolGrey),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: AppColors.darkGrey, fontSize: 13),
        ),
      ],
    );
  }
}
