import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../models/dcr.dart';
import '../../routes/app_router.dart';

class DCRDetailsBottomSheet extends StatelessWidget {
  final DCRModel dcr;
  final Function(DCRStatus) onStatusUpdate;

  const DCRDetailsBottomSheet({
    super.key,
    required this.dcr,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.coolGrey.withAlpha(50),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DCR DETAILS',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                    ),
                    Text(
                      '#${dcr.id}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    context.pop();
                    context.push(AppRouter.createEditDcr, extra: dcr);
                  },
                  icon: const Icon(Iconsax.edit, color: AppColors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  _buildDetailRow(Iconsax.user, 'Doctor Name', dcr.doctor.name),
                  _buildDetailRow(Iconsax.award, 'Specialization', dcr.doctor.specialization),
                  _buildDetailRow(Iconsax.hospital, 'Place of DCR', dcr.place),
                  _buildDetailRow(Iconsax.calendar, 'Date', dcr.date),
                  _buildDetailRow(Iconsax.timer, 'Time', dcr.time),
                  const SizedBox(height: 24),
                  Text(
                    'VISUAL ADS PRESENTED',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                  ),
                  const SizedBox(height: 12),
                  if (dcr.visualAds.isEmpty)
                    const Text('No visual ads selected.', style: TextStyle(color: AppColors.coolGrey, fontSize: 13))
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: dcr.visualAds.map((ad) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          ad.productName,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      )).toList(),
                    ),
                  const SizedBox(height: 32),
                  Text(
                    'UPDATE STATUS',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: DCRStatus.values.map((status) {
                      final isSelected = dcr.status == status;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () => onStatusUpdate(status),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.black : AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: isSelected ? AppColors.black : AppColors.coolGrey.withAlpha(30)),
                              ),
                              child: Text(
                                status.name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? AppColors.white : AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.pop();
                        context.push(AppRouter.visualAds, extra: dcr.visualAds);
                      },
                      icon: const Icon(Iconsax.presention_chart, color: AppColors.white),
                      label: const Text('PRESENT NOW', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.black),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.coolGrey, fontWeight: FontWeight.w600)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}
