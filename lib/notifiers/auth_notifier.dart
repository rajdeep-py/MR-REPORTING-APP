import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String phone, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (phone == "9876543210" && password == "password") {
      final user = UserModel(
        id: "1",
        name: "John Doe",
        phone: phone,
        role: "Medical Representative",
        designation: "Senior MR",
        company: "MR Pharma Ltd.",
        email: "john.doe@mrpharma.com",
        hq: "Mumbai Central",
        areaOfWork: "South Mumbai",
        altPhone: "9820012345",
        altEmail: "john.personal@gmail.com",
        address: "123, Ocean View Apts, Marine Drive, Mumbai - 400020",
        password: password,
      );
      state = state.copyWith(user: user, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false, error: "Invalid credentials. Please contact your organization.");
    }
  }

  void logout() {
    state = AuthState();
  }
}

