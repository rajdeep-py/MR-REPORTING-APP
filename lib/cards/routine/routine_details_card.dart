import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../models/routine.dart';

class RoutineDetailsCard extends StatelessWidget {
  final RoutineModel? routine;
  final DateTime selectedDate;
  final Function(String) onToggleTask;

  const RoutineDetailsCard({
    super.key,
    this.routine,
    required this.selectedDate,
    required this.onToggleTask,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);
    final tasks = routine?.tasks ?? [];

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.black.withAlpha(10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${tasks.length} TASKS',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          AppGaps.largeV,
          if (tasks.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No routine scheduled for this day.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, thickness: 0.5),
              ),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return _buildTaskItem(context, task);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, RoutineTask task) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: task.isCompleted ? AppColors.success.withAlpha(20) : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            task.isCompleted ? Iconsax.tick_circle : Iconsax.clock,
            color: task.isCompleted ? AppColors.success : AppColors.coolGrey,
            size: 20,
          ),
        ),
        AppGaps.mediumH,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted ? AppColors.coolGrey : AppColors.black,
                ),
              ),
              Text(
                task.time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
        Checkbox(
          value: task.isCompleted,
          activeColor: AppColors.black,
          onChanged: (_) => onToggleTask(task.id),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }
}
