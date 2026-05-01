import 'package:flutter_riverpod/legacy.dart';
import '../models/doctor.dart';

class DoctorState {
  final List<DoctorModel> allDoctors;
  final List<DoctorModel> filteredDoctors;
  final String searchQuery;
  final String? specializationFilter;
  final bool isLoading;

  DoctorState({
    required this.allDoctors,
    required this.filteredDoctors,
    this.searchQuery = '',
    this.specializationFilter,
    this.isLoading = false,
  });

  DoctorState copyWith({
    List<DoctorModel>? allDoctors,
    List<DoctorModel>? filteredDoctors,
    String? searchQuery,
    String? specializationFilter,
    bool? isLoading,
  }) {
    return DoctorState(
      allDoctors: allDoctors ?? this.allDoctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      searchQuery: searchQuery ?? this.searchQuery,
      specializationFilter: specializationFilter ?? this.specializationFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DoctorNotifier extends StateNotifier<DoctorState> {
  DoctorNotifier() : super(DoctorState(allDoctors: [], filteredDoctors: [])) {
    _loadMockDoctors();
  }

  void _loadMockDoctors() {
    final mock = [
      DoctorModel(
        id: '1',
        name: 'Dr. Arnab Das',
        specialization: 'Orthopedic Surgeon',
        experience: '15 Years',
        qualification: 'MBBS, MS (Ortho)',
        birthday: '12th August',
        description:
            'Renowned orthopedic surgeon specializing in joint replacements and sports injuries.',
        phone: '+91 98300 11223',
        email: 'arnab.das@health.com',
        address: 'Salt Lake, Sector 5, Kolkata',
        chambers: [
          DoctorChamber(
            name: 'Apollo Clinic',
            address: 'Salt Lake',
            phone: '033 2345 6789',
          ),
          DoctorChamber(
            name: 'Medica Superspecialty',
            address: 'EM Bypass',
            phone: '033 6652 0000',
          ),
        ],
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Priya Mehta',
        specialization: 'Cardiologist',
        experience: '10 Years',
        qualification: 'MBBS, MD, DM (Cardio)',
        birthday: '25th December',
        description:
            'Expert in non-invasive cardiology and preventative heart care.',
        phone: '+91 98300 44556',
        email: 'priya.mehta@care.com',
        address: 'Ballygunge, Kolkata',
        chambers: [
          DoctorChamber(
            name: 'Woodlands Hospital',
            address: 'Alipore',
            phone: '033 2456 1234',
          ),
        ],
      ),
    ];
    state = state.copyWith(allDoctors: mock, filteredDoctors: mock);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void setSpecializationFilter(String? specialization) {
    state = state.copyWith(specializationFilter: specialization);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.allDoctors;

    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (d) =>
                d.name.toLowerCase().contains(state.searchQuery.toLowerCase()),
          )
          .toList();
    }

    if (state.specializationFilter != null) {
      filtered = filtered
          .where((d) => d.specialization == state.specializationFilter)
          .toList();
    }

    state = state.copyWith(filteredDoctors: filtered);
  }

  void addDoctor(DoctorModel doctor) {
    final newList = [...state.allDoctors, doctor];
    state = state.copyWith(allDoctors: newList);
    _applyFilters();
  }

  void updateDoctor(DoctorModel doctor) {
    final newList = state.allDoctors
        .map((d) => d.id == doctor.id ? doctor : d)
        .toList();
    state = state.copyWith(allDoctors: newList);
    _applyFilters();
  }
}

final doctorNotifierProvider =
    StateNotifierProvider<DoctorNotifier, DoctorState>((ref) {
      return DoctorNotifier();
    });
