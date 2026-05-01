import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/auth_notifier.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
