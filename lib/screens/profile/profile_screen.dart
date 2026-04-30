import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../providers/profile_provider.dart';
import '../../models/user.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _hqController;
  late TextEditingController _areaController;
  late TextEditingController _altPhoneController;
  late TextEditingController _altEmailController;
  late TextEditingController _addressController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(profileProvider).user;
    _nameController = TextEditingController(text: user?.name);
    _phoneController = TextEditingController(text: user?.phone);
    _emailController = TextEditingController(text: user?.email);
    _hqController = TextEditingController(text: user?.hq);
    _areaController = TextEditingController(text: user?.areaOfWork);
    _altPhoneController = TextEditingController(text: user?.altPhone);
    _altEmailController = TextEditingController(text: user?.altEmail);
    _addressController = TextEditingController(text: user?.address);
    _passwordController = TextEditingController(text: user?.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _hqController.dispose();
    _areaController.dispose();
    _altPhoneController.dispose();
    _altEmailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final currentUser = ref.read(profileProvider).user!;
      final updatedUser = currentUser.copyWith(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        hq: _hqController.text,
        areaOfWork: _areaController.text,
        altPhone: _altPhoneController.text,
        altEmail: _altEmailController.text,
        address: _addressController.text,
        password: _passwordController.text,
      );

      await ref.read(profileProvider.notifier).updateProfile(updatedUser);
      
      if (mounted) {
        AppTheme.showPremiumSnackBar(
          context: context,
          message: "Profile updated successfully!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final user = profileState.user;

    if (user == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: '/profile'),
      appBar: const CustomAppBar(
        title: 'My Profile',
        subtitle: 'Personal & Professional Details',
        showDrawerButton: true,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(user),
              AppGaps.extraLargeV,
              
              _buildSectionTitle('PROFESSIONAL DETAILS'),
              AppGaps.mediumV,
              _buildTextField('Company Name', user.company, Iconsax.building, enabled: false),
              AppGaps.mediumV,
              _buildTextField('Designation', user.designation, Iconsax.user_tag, enabled: false),
              AppGaps.mediumV,
              _buildTextField('Headquarter Assigned', '', Iconsax.location, controller: _hqController),
              AppGaps.mediumV,
              _buildTextField('Area of Work', '', Iconsax.map_1, controller: _areaController),
              
              AppGaps.extraLargeV,
              _buildSectionTitle('PERSONAL DETAILS'),
              AppGaps.mediumV,
              _buildTextField('Full Name', '', Iconsax.user, controller: _nameController),
              AppGaps.mediumV,
              _buildTextField('Phone Number', '', Iconsax.call, controller: _phoneController, keyboardType: TextInputType.phone),
              AppGaps.mediumV,
              _buildTextField('Email Address', '', Iconsax.sms, controller: _emailController, keyboardType: TextInputType.emailAddress),
              AppGaps.mediumV,
              _buildTextField('Alternative Phone', '', Iconsax.call, controller: _altPhoneController, keyboardType: TextInputType.phone),
              AppGaps.mediumV,
              _buildTextField('Alternative Email', '', Iconsax.sms, controller: _altEmailController, keyboardType: TextInputType.emailAddress),
              AppGaps.mediumV,
              _buildTextField('Residential Address', '', Iconsax.house, controller: _addressController, maxLines: 3),
              
              AppGaps.extraLargeV,
              _buildSectionTitle('SECURITY'),
              AppGaps.mediumV,
              _buildTextField('Password', '', Iconsax.lock, controller: _passwordController, isPassword: true),
              
              AppGaps.extraLargeV,
              ElevatedButton(
                onPressed: profileState.isLoading ? null : _updateProfile,
                child: profileState.isLoading 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white))
                  : const Text('UPDATE PROFILE'),
              ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserModel user) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.black.withAlpha(20), width: 4),
                ),
                child: const Icon(Iconsax.user, size: 60, color: AppColors.black),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Iconsax.camera, color: AppColors.white, size: 18),
                ),
              ),
            ],
          ),
          AppGaps.mediumV,
          Text(
            user.name,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24, color: AppColors.black),
          ),
          Text(
            '${user.designation} • ${user.company}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    String initialValue, 
    IconData icon, {
    TextEditingController? controller,
    bool enabled = true,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
        ),
        AppGaps.smallV,
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          enabled: enabled,
          obscureText: isPassword,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            color: enabled ? AppColors.black : AppColors.coolGrey,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: AppColors.coolGrey),
            filled: true,
            fillColor: enabled ? AppColors.surface : AppColors.lightGrey.withAlpha(100),
          ),
        ),
      ],
    );
  }
}
