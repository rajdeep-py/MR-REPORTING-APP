import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import '../../notifiers/team_notifier.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../cards/team/team_header_card.dart';
import '../../cards/team/team_description_card.dart';
import '../../cards/team/team_target_area_of_work_card.dart';
import '../../cards/team/team_member_card.dart';

class TeamDetailsScreen extends ConsumerWidget {
  final String teamId;

  const TeamDetailsScreen({super.key, required this.teamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamNotifierProvider);
    final team = teamState.teams.firstWhereOrNull((t) => t.id == teamId);

    if (team == null) {
      return const Scaffold(body: Center(child: Text('Team not found')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: team.name,
        subtitle: 'Team Performance & Roster',
        showBackButton: true,
        showDrawerButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TeamHeaderCard(
              name: team.name,
              memberCount: team.membersCount,
              photoUrl: team.photoUrl,
            ),
            AppGaps.largeV,
            TeamDescriptionCard(description: team.description),
            AppGaps.largeV,
            TeamTargetAreaOfWorkCard(
              target: team.monthlyTarget,
              areas: team.areasOfWork,
            ),
            AppGaps.largeV,
            Text(
              'TEAM MEMBERS',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            AppGaps.mediumV,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: team.members.length,
              separatorBuilder: (context, index) => AppGaps.mediumV,
              itemBuilder: (context, index) {
                return TeamMemberCard(member: team.members[index]);
              },
            ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
