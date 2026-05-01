import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_theme.dart';
import '../../models/routine.dart';

class RoutineDetailsCard extends StatelessWidget {
  final RoutineModel? routine;
  final DateTime selectedDate;
  final Function(String, bool) onToggleTask; // Added current status

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

    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(32), // More rounded
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(5),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(color: AppColors.coolGrey.withAlpha(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Your schedule for today',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${tasks.length} TASKS',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            AppGaps.extraLargeV,
            if (tasks.isEmpty)
              _buildEmptyState(context)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _buildTaskItem(context, task, index);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Iconsax.calendar_remove, color: AppColors.coolGrey.withAlpha(100), size: 48),
            AppGaps.mediumV,
            Text(
              'No routine scheduled for this day.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, RoutineTask task, int index) {
    return FadeInLeft(
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 400),
      child: InkWell(
        onTap: () => onToggleTask(task.id, task.isCompleted),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: task.isCompleted ? AppColors.success.withAlpha(10) : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: task.isCompleted ? AppColors.success.withAlpha(30) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: task.isCompleted ? AppColors.success : AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    if (!task.isCompleted)
                      BoxShadow(
                        color: AppColors.black.withAlpha(5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Icon(
                  task.isCompleted ? Iconsax.tick_circle : Iconsax.clock,
                  color: task.isCompleted ? AppColors.white : AppColors.black,
                  size: 22,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: task.isCompleted ? AppColors.coolGrey : AppColors.black,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Iconsax.timer_1, size: 12, color: AppColors.coolGrey),
                        const SizedBox(width: 4),
                        Text(
                          task.time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildModernCheckbox(task.isCompleted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernCheckbox(bool isCompleted) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.black : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isCompleted ? AppColors.black : AppColors.coolGrey.withAlpha(100),
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(Icons.check, color: AppColors.white, size: 14)
          : null,
    );
  }
}
