import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/team_notifier.dart';

final teamProvider = Provider<TeamState>((ref) {
  return ref.watch(teamNotifierProvider);
});
