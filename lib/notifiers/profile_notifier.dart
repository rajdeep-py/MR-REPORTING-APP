import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class ProfileState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  ProfileState({this.user, this.isLoading = false, this.error});

  ProfileState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(UserModel? initialUser) : super(ProfileState(user: initialUser));

  void setUser(UserModel user) {
    state = state.copyWith(user: user);
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    state = state.copyWith(user: updatedUser, isLoading: false);
  }
}
