import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/doctor_notifier.dart';
import '../../cards/doctor/doctor_card.dart';
import '../../cards/doctor/doctor_search_filter_card.dart';
import '../../routes/app_router.dart';

class MyDoctorScreen extends ConsumerWidget {
  const MyDoctorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorState = ref.watch(doctorNotifierProvider);
    final doctorNotifier = ref.read(doctorNotifierProvider.notifier);

    final specializations = doctorState.allDoctors
        .map((d) => d.specialization)
        .toSet()
        .toList();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.home);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: '/doctors'),
        appBar: CustomAppBar(
          title: 'My Doctors',
          subtitle: 'Manage your professional contacts',
          showDrawerButton: true,
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: () => context.push(AppRouter.addEditDoctor),
              icon: const Icon(Iconsax.user_add, color: AppColors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Column(
            children: [
              DoctorSearchFilterCard(
                onSearch: doctorNotifier.setSearchQuery,
                onFilter: doctorNotifier.setSpecializationFilter,
                specializations: specializations,
                selectedSpecialization: doctorState.specializationFilter,
              ),
              AppGaps.largeV,
              if (doctorState.filteredDoctors.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No doctors found matching your criteria.'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctorState.filteredDoctors.length,
                  separatorBuilder: (context, index) => AppGaps.mediumV,
                  itemBuilder: (context, index) {
                    final doctor = doctorState.filteredDoctors[index];
                    return DoctorCard(
                      doctor: doctor,
                      onTap: () => context.push(
                        AppRouter.doctorDetail.replaceFirst(
                          ':doctorId',
                          doctor.id,
                        ),
                      ),
                    );
                  },
                ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }
}
