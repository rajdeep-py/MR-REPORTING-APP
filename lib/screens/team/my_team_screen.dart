import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../providers/team_provider.dart';
import '../../cards/team/team_card.dart';

class MyTeamScreen extends ConsumerWidget {
  const MyTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: '/team'),
      appBar: const CustomAppBar(
        title: 'My Team',
        subtitle: 'Manage your professional network',
        showDrawerButton: true,
        showBackButton: false,
      ),
      body: teamState.teams.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(AppGaps.screenPadding),
              itemCount: teamState.teams.length,
              separatorBuilder: (context, index) => AppGaps.largeV,
              itemBuilder: (context, index) {
                final team = teamState.teams[index];
                return TeamCard(
                  team: team,
                  onTap: () {
                    context.push(
                      AppRouter.teamDetails.replaceFirst(':teamId', team.id),
                    );
                  },
                );
              },
            ),
    );
  }
}
