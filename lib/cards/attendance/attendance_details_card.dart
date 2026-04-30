import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../models/attendance.dart';

class AttendanceDetailsCard extends StatelessWidget {
  final AttendanceModel? attendance;
  final DateTime selectedDate;

  const AttendanceDetailsCard({
    super.key,
    this.attendance,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);
    final bool hasData = attendance != null;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
              ),
              if (hasData)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: (attendance!.isPresent ? AppColors.success : AppColors.error).withAlpha(26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    attendance!.isPresent ? 'PRESENT' : 'ABSENT',
                    style: TextStyle(
                      color: attendance!.isPresent ? AppColors.success : AppColors.error,
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ),
            ],
          ),
          AppGaps.largeV,
          if (hasData && attendance!.isPresent)
            Column(
              children: [
                Row(
                  children: [
                    _buildTimeInfo(context, 'Check In', attendance!.checkIn ?? '--:--', Iconsax.login_1, AppColors.success),
                    const Spacer(),
                    _buildTimeInfo(context, 'Check Out', attendance!.checkOut ?? '--:--', Iconsax.logout_1, AppColors.error),
                  ],
                ),
                AppGaps.largeV,
                const Divider(height: 1, thickness: 0.5),
                AppGaps.largeV,
                Row(
                  children: [
                    _buildTimeInfo(context, 'Break In', attendance!.breakIn ?? '--:--', Iconsax.coffee, AppColors.darkGrey),
                    const Spacer(),
                    _buildTimeInfo(context, 'Break Out', attendance!.breakOut ?? '--:--', Iconsax.timer_1, AppColors.darkGrey),
                  ],
                ),
              ],
            )
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  hasData ? 'No working hours recorded for this day.' : 'No data available for this date.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(BuildContext context, String label, String time, IconData icon, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        AppGaps.mediumH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
