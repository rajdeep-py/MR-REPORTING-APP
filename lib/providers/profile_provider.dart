import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/profile_notifier.dart';
import '../providers/auth_provider.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  final authState = ref.watch(authProvider);
  return ProfileNotifier(authState.user);
});
