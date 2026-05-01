import 'package:flutter_riverpod/legacy.dart';
import '../models/about_us.dart';

class AboutUsNotifier extends StateNotifier<AboutUsModel?> {
  AboutUsNotifier() : super(null) {
    _loadData();
  }

  void _loadData() {
    state = AboutUsModel(
      companyName: 'Naiyo24',
      tagline: 'Where Innovation meets Business!',
      description:
          'Naiyo24 is a cutting-edge MR Management System designed to empower Medical Representatives with state-of-the-art digital tools. Our platform streamlines daily operations, from attendance tracking to DCR management, ensuring that every interaction counts. We believe in bridging the gap between pharmaceutical excellence and technological innovation.',
      directorName: 'Mr. Rajesh Sharma',
      directorMessage:
          'Our vision at Naiyo24 is to revolutionize the way medical representatives work. We are committed to providing a seamless, data-driven experience that enhances productivity and fosters professional growth. Thank you for being a part of our journey towards a more efficient healthcare ecosystem.',
      phone: '+91 98765 43210',
      email: 'contact@naiyo24.com',
      address:
          '4th Floor, Tech Hub Towers, Electronic City, Bangalore - 560100',
      website: 'www.naiyo24.com',
    );
  }
}

final aboutUsProvider = StateNotifierProvider<AboutUsNotifier, AboutUsModel?>((
  ref,
) {
  return AboutUsNotifier();
});
