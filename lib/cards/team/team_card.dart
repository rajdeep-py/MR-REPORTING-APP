import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../models/team.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  final VoidCallback? onTap;

  const TeamCard({
    super.key,
    required this.team,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Photo Section
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.black.withAlpha(10),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: team.photoUrl != null
                    ? Image.network(team.photoUrl!, fit: BoxFit.cover)
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.people, color: AppColors.coolGrey.withAlpha(150), size: 48),
                            const SizedBox(height: 8),
                            Text(
                              'Team Workspace',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            
            // Team Info Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        team.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${team.membersCount} MEMBERS',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    team.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 13,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Iconsax.info_circle, size: 14, color: AppColors.coolGrey),
                      const SizedBox(width: 6),
                      Text(
                        'View full details',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.coolGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.black),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
