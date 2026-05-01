import 'package:flutter_riverpod/legacy.dart';
import '../models/privacy_policy.dart';
import '../models/terms_conditions.dart';

class SettingsState {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final List<PrivacyPolicyModel> privacyPolicies;
  final List<TermsConditionsModel> termsConditions;

  SettingsState({
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.privacyPolicies = const [],
    this.termsConditions = const [],
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    List<PrivacyPolicyModel>? privacyPolicies,
    List<TermsConditionsModel>? termsConditions,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      privacyPolicies: privacyPolicies ?? this.privacyPolicies,
      termsConditions: termsConditions ?? this.termsConditions,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState()) {
    _loadLegalData();
  }

  void toggleDarkMode(bool value) => state = state.copyWith(isDarkMode: value);
  void toggleNotifications(bool value) =>
      state = state.copyWith(notificationsEnabled: value);

  void _loadLegalData() {
    state = state.copyWith(
      privacyPolicies: [
        PrivacyPolicyModel(
          header: 'Data Collection',
          description:
              'We collect minimal data required for field operations, including location during working hours and visit reports.',
        ),
        PrivacyPolicyModel(
          header: 'Data Usage',
          description:
              'Your data is strictly used for performance reporting and operational efficiency within the organization.',
        ),
      ],
      termsConditions: [
        TermsConditionsModel(
          header: 'Usage Agreement',
          description:
              'By using this app, you agree to report accurate field data and adhere to the corporate code of conduct.',
        ),
        TermsConditionsModel(
          header: 'Account Security',
          description:
              'Users are responsible for maintaining the confidentiality of their credentials and all activities under their account.',
        ),
      ],
    );
  }
}

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
      return SettingsNotifier();
    });
