import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../cards/auth/contact_support_bottomsheet.dart';
import '../../cards/auth/get_demo_bottomsheet.dart';
import '../../routes/app_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      AppTheme.showPremiumSnackBar(
        context: context,
        message: "Please fill in all fields",
        isError: true,
      );
      return;
    }

    await ref.read(authProvider.notifier).login(phone, password);

    final authState = ref.read(authProvider);
    if (authState.user != null) {
      if (mounted) {
        context.go(AppRouter.profile);
      }
    } else if (authState.error != null) {
      if (mounted) {
        AppTheme.showModernDialog(
          context: context,
          title: "Login Failed",
          message: authState.error!,
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppGaps.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.extraLargeV,
              Text(
                'Welcome Back!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              AppGaps.smallV,
              Text(
                'Hey MR! Just drop your phone and password from the HQ and you\'re in. Ready to crush some calls?',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppGaps.mediumV,

              // Phone Input
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: AppColors.black),
                decoration: const InputDecoration(
                  hintText: 'Your Phone Number',
                  prefixIcon: Icon(Iconsax.call, color: AppColors.midGrey),
                ),
              ),
              AppGaps.mediumV,

              // Password Input
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(color: AppColors.black),
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: const Icon(
                    Iconsax.lock,
                    color: AppColors.midGrey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                      color: AppColors.midGrey,
                    ),
                    onPressed: () => setState(
                      () => _isPasswordVisible = !_isPasswordVisible,
                    ),
                  ),
                ),
              ),
              AppGaps.mediumV,

              // Sign In Button
              ElevatedButton(
                onPressed: authState.isLoading ? null : _handleLogin,
                child: authState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.black,
                        ),
                      )
                    : const Text('SIGN IN'),
              ),
              AppGaps.largeV,

              // Support Text
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Having Issues while signing in? ',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Contact support',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              ContactSupportBottomSheet.show(context),
                      ),
                    ],
                  ),
                ),
              ),

              AppGaps.mediumV,
              const Divider(color: AppColors.darkGrey, thickness: 1),
              AppGaps.mediumV,

              // Demo Text
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'New to MR App? ',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Get a Demo',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => GetDemoBottomSheet.show(context),
                      ),
                    ],
                  ),
                ),
              ),
              AppGaps.largeV,
            ],
          ),
        ),
      ),
    );
  }
}
