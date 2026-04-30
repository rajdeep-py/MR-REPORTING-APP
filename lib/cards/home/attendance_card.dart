import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../models/attendance.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel? todayAttendance;
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;
  final VoidCallback onBreakIn;
  final VoidCallback onBreakOut;

  const AttendanceCard({
    super.key,
    this.todayAttendance,
    required this.onCheckIn,
    required this.onCheckOut,
    required this.onBreakIn,
    required this.onBreakOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'DAILY ATTENDANCE',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              if (todayAttendance?.checkIn != null)
                const Icon(Iconsax.tick_circle, color: AppColors.success, size: 20),
            ],
          ),
          AppGaps.largeV,
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  context,
                  'Check In',
                  todayAttendance?.checkIn ?? '--:--',
                  Iconsax.login_1,
                  AppColors.success,
                  todayAttendance?.checkIn == null ? onCheckIn : null,
                ),
              ),
              AppGaps.mediumH,
              Expanded(
                child: _buildActionBtn(
                  context,
                  'Check Out',
                  todayAttendance?.checkOut ?? '--:--',
                  Iconsax.logout_1,
                  AppColors.error,
                  todayAttendance?.checkIn != null && todayAttendance?.checkOut == null ? onCheckOut : null,
                ),
              ),
            ],
          ),
          AppGaps.mediumV,
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  context,
                  'Break In',
                  todayAttendance?.breakIn ?? '--:--',
                  Iconsax.coffee,
                  AppColors.darkGrey,
                  todayAttendance?.checkIn != null && todayAttendance?.breakIn == null ? onBreakIn : null,
                ),
              ),
              AppGaps.mediumH,
              Expanded(
                child: _buildActionBtn(
                  context,
                  'Break Out',
                  todayAttendance?.breakOut ?? '--:--',
                  Iconsax.timer_1,
                  AppColors.darkGrey,
                  todayAttendance?.breakIn != null && todayAttendance?.breakOut == null ? onBreakOut : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(
    BuildContext context,
    String label,
    String time,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    final bool isDisabled = onTap == null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDisabled ? AppColors.lightGrey.withAlpha(50) : color.withAlpha(15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDisabled ? Colors.transparent : color.withAlpha(30),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isDisabled ? AppColors.coolGrey : color, size: 24),
            AppGaps.smallV,
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isDisabled ? AppColors.coolGrey : AppColors.black,
              ),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 14,
                color: isDisabled ? AppColors.coolGrey : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
