import 'package:flutter_riverpod/legacy.dart';
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
    state = state.copyWith(
      teams: [
        TeamModel(
          id: '1',
          name: 'Elite Avengers',
          membersCount: 4,
          description:
              'Primary sales team focusing on specialized orthopedic medicine in South Mumbai region. We handle over 50+ premium clinic accounts.',
          monthlyTarget: 1500000,
          areasOfWork: ['Kolkata', 'Delhi', 'Mumbai'],
          members: [
            TeamMember(id: 'm1', name: 'Amit Kumar', phone: '+91 98300 12345'),
            TeamMember(id: 'm2', name: 'Sanjay Dutt', phone: '+91 98300 67890'),
            TeamMember(id: 'm3', name: 'Priya Singh', phone: '+91 98300 11111'),
            TeamMember(id: 'm4', name: 'Rahul Bose', phone: '+91 98300 22222'),
          ],
        ),
        TeamModel(
          id: '2',
          name: 'Pharma Warriors',
          membersCount: 3,
          description:
              'Dedicated team for cardiovascular product launches and relationship building in North Mumbai.',
          monthlyTarget: 1200000,
          areasOfWork: ['Gurgaon', 'Noida', 'Faridabad'],
          members: [
            TeamMember(id: 'm5', name: 'Deepak Raj', phone: '+91 98400 33333'),
            TeamMember(id: 'm6', name: 'Sneha Kapur', phone: '+91 98400 44444'),
            TeamMember(id: 'm7', name: 'Vikram Seth', phone: '+91 98400 55555'),
          ],
        ),
      ],
    );
  }
}

final teamNotifierProvider = StateNotifierProvider<TeamNotifier, TeamState>((
  ref,
) {
  return TeamNotifier();
});
