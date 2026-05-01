import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/doctor_notifier.dart';

final doctorProvider = Provider<DoctorState>((ref) {
  return ref.watch(doctorNotifierProvider);
});
