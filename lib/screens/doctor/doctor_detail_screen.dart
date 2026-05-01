import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../notifiers/doctor_notifier.dart';
import '../../cards/doctor/doctor_header_card.dart';
import '../../cards/doctor/doctor_qualification_specialization_card.dart';
import '../../cards/doctor/doctor_description_card.dart';
import '../../cards/doctor/doctor_chamber_card.dart';
import '../../cards/doctor/doctor_contact_card.dart';
import '../../routes/app_router.dart';

class DoctorDetailScreen extends ConsumerWidget {
  final String doctorId;

  const DoctorDetailScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorState = ref.watch(doctorNotifierProvider);
    final doctor = doctorState.allDoctors.firstWhereOrNull((d) => d.id == doctorId);

    if (doctor == null) {
      return const Scaffold(body: Center(child: Text('Doctor not found')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: doctor.name,
        subtitle: doctor.specialization,
        showBackButton: true,
        showDrawerButton: false,
        actions: [
          IconButton(
            onPressed: () => context.push(
              AppRouter.addEditDoctor,
              extra: doctor, // Passing doctor object for editing
            ),
            icon: const Icon(Iconsax.edit, color: AppColors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          children: [
            DoctorHeaderCard(
              name: doctor.name,
              specialization: doctor.specialization,
              birthday: doctor.birthday,
              photoUrl: doctor.photoUrl,
            ),
            AppGaps.largeV,
            DoctorQualificationSpecializationCard(
              qualification: doctor.qualification,
              specialization: doctor.specialization,
              experience: doctor.experience,
            ),
            AppGaps.largeV,
            DoctorDescriptionCard(description: doctor.description),
            AppGaps.largeV,
            DoctorChamberCard(chambers: doctor.chambers),
            AppGaps.largeV,
            DoctorContactCard(
              phone: doctor.phone,
              email: doctor.email,
              address: doctor.address,
            ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
