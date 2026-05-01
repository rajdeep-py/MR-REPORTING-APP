import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/app_theme.dart';
import '../routes/app_router.dart';

class SideNavBar extends StatelessWidget {
  final String currentRoute;

  const SideNavBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(
              height: 1,
              thickness: 0.5,
              color: AppColors.lightGrey,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('MAIN'),
                    _buildMenuItem(
                      context,
                      'Home',
                      Iconsax.home,
                      AppRouter.home,
                    ),

                    _buildSectionHeader('DAILY OPERATIONS'),
                    _buildMenuItem(
                      context,
                      'Attendance Record',
                      Iconsax.calendar_tick,
                      AppRouter.attendance,
                    ),
                    _buildMenuItem(
                      context,
                      'My Routine',
                      Iconsax.status,
                      AppRouter.routine,
                    ),
                    _buildMenuItem(
                      context,
                      'DCR',
                      Iconsax.document_text,
                      AppRouter.dcr,
                    ),
                    _buildMenuItem(
                      context,
                      'Expense Tracker',
                      Iconsax.money,
                      AppRouter.expenses,
                    ),

                    _buildSectionHeader('RELATIONSHIPS'),
                    _buildMenuItem(
                      context,
                      'My Team',
                      Iconsax.people,
                      AppRouter.team,
                    ),
                    _buildMenuItem(
                      context,
                      'My Doctors',
                      Iconsax.user_tag,
                      AppRouter.doctors,
                    ),
                    _buildMenuItem(
                      context,
                      'My Chemist Shops',
                      Iconsax.shop,
                      AppRouter.chemist,
                    ),
                    _buildMenuItem(
                      context,
                      'My Stockists',
                      Iconsax.box,
                      AppRouter.stockist,
                    ),

                    _buildSectionHeader('SALES & PERFORMANCE'),
                    _buildMenuItem(
                      context,
                      'Monthly Target',
                      Iconsax.graph,
                      AppRouter.target,
                    ),
                    _buildMenuItem(
                      context,
                      'Visual Ads',
                      Iconsax.gallery,
                      AppRouter.visualAds,
                    ),
                    _buildMenuItem(
                      context,
                      'My Orders',
                      Iconsax.shopping_cart,
                      AppRouter.orders,
                    ),
                    _buildMenuItem(
                      context,
                      'Request Gifts',
                      Iconsax.gift,
                      AppRouter.gifts,
                    ),

                    _buildSectionHeader('ACCOUNT'),
                    _buildMenuItem(
                      context,
                      'Profile',
                      Iconsax.profile_circle,
                      AppRouter.profile,
                    ),
                    _buildMenuItem(
                      context,
                      'Settings',
                      Iconsax.setting_2,
                      AppRouter.settings,
                    ),
                    _buildMenuItem(
                      context,
                      'About Us',
                      Iconsax.info_circle,
                      AppRouter.about,
                    ),
                    _buildMenuItem(
                      context,
                      'Notifications',
                      Iconsax.notification,
                      AppRouter.notifications,
                    ),

                    AppGaps.largeV,
                    _buildLogoutButton(context),
                    AppGaps.mediumV,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/logo/logo.png',
                color: AppColors.white,
              ),
            ),
          ),
          AppGaps.mediumH,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Naiyo24',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  'Where Innovation meets Business!',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: AppColors.coolGrey,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    final bool isSelected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pop(context); // Close drawer
          context.push(route);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? AppColors.white : AppColors.darkGrey,
              ),
              AppGaps.mediumH,
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton.icon(
        onPressed: () {
          // Implement logout logic
          context.go(AppRouter.login);
        },
        icon: const Icon(Iconsax.logout, color: AppColors.error, size: 20),
        label: const Text(
          'LOGOUT',
          style: TextStyle(
            color: AppColors.error,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
