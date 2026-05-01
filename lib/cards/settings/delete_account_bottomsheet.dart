import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';

class DeleteAccountBottomSheet extends StatefulWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  State<DeleteAccountBottomSheet> createState() => _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState extends State<DeleteAccountBottomSheet> {
  final _passwordCtrl = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _handleDelete() {
    if (_passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password to confirm')),
      );
      return;
    }
    
    // Logic for account deletion would go here
    context.go(AppRouter.splash);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.coolGrey.withAlpha(50),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Icon(Iconsax.danger, color: Colors.red, size: 24),
                SizedBox(width: 12),
                Text(
                  'DELETE ACCOUNT',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Colors.red,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'This action is irreversible. All your data, including visit reports, attendance, and profile information, will be permanently removed.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  const Text(
                    'ENTER PASSWORD TO CONFIRM',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.coolGrey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordCtrl,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Your Account Password',
                      prefixIcon: const Icon(Iconsax.lock, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                          size: 20,
                          color: AppColors.coolGrey,
                        ),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'PERMANENTLY DELETE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: AppColors.coolGrey,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
