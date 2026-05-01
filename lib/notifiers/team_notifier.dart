import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team.dart';

class TeamState {
  final List<TeamModel> teams;
  final bool isLoading;

  TeamState({required this.teams, this.isLoading = false});

  TeamState copyWith({List<TeamModel>? teams, bool? isLoading}) {
    return TeamState(
      teams: teams ?? this.teams,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TeamNotifier extends StateNotifier<TeamState> {
  TeamNotifier() : super(TeamState(teams: [])) {
    _loadMockTeams();
  }

  void _loadMockTeams() {
    state = state.copyWith(teams: [
      TeamModel(
        id: '1',
        name: 'Elite Avengers',
        membersCount: 12,
        description: 'Primary sales team focusing on specialized orthopedic medicine in South Mumbai region.',
      ),
      TeamModel(
        id: '2',
        name: 'Pharma Warriors',
        membersCount: 8,
        description: 'Dedicated team for cardiovascular product launches and relationship building in North Mumbai.',
      ),
      TeamModel(
        id: '3',
        name: 'Vitality Squad',
        membersCount: 15,
        description: 'Multi-disciplinary team handling general physician visits and hospital channel distribution.',
      ),
    ]);
  }
}

final teamNotifierProvider = StateNotifierProvider<TeamNotifier, TeamState>((ref) {
  return TeamNotifier();
});
