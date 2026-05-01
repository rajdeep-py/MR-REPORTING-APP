import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../widgets/footer.dart';
import '../../providers/about_us_provider.dart';
import '../../cards/about_us/company_header_card.dart';
import '../../cards/about_us/company_description_card.dart';
import '../../cards/about_us/director_message_card.dart';
import '../../cards/about_us/company_contact_card.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutUs = ref.watch(aboutUsDataProvider);

    if (aboutUs == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: '/about'),
      appBar: const CustomAppBar(
        title: 'About Us',
        subtitle: 'Our Vision & Values',
        showDrawerButton: false,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppGaps.screenPadding),
              child: Column(
                children: [
                  CompanyHeaderCard(
                    companyName: aboutUs.companyName,
                    tagline: aboutUs.tagline,
                  ),
                  AppGaps.largeV,
                  CompanyDescriptionCard(
                    description: aboutUs.description,
                  ),
                  AppGaps.largeV,
                  DirectorMessageCard(
                    directorName: aboutUs.directorName,
                    message: aboutUs.directorMessage,
                  ),
                  AppGaps.largeV,
                  CompanyContactCard(
                    phone: aboutUs.phone,
                    email: aboutUs.email,
                    address: aboutUs.address,
                    website: aboutUs.website,
                  ),
                  AppGaps.extraLargeV,
                ],
              ),
            ),
            CustomFooter(
              headerText: aboutUs.companyName,
              tagline: aboutUs.tagline,
            ),
          ],
        ),
      ),
    );
  }
}
