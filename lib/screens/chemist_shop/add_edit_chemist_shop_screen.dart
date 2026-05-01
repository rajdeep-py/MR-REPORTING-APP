import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/chemist_shop.dart';
import '../../notifiers/chemist_shop_notifier.dart';

class AddEditChemistShopScreen extends ConsumerStatefulWidget {
  final ChemistShopModel? shopToEdit;

  const AddEditChemistShopScreen({super.key, this.shopToEdit});

  @override
  ConsumerState<AddEditChemistShopScreen> createState() =>
      _AddEditChemistShopScreenState();
}

class _AddEditChemistShopScreenState
    extends ConsumerState<AddEditChemistShopScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _descriptionCtrl;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    final s = widget.shopToEdit;
    _nameCtrl = TextEditingController(text: s?.name);
    _addressCtrl = TextEditingController(text: s?.address);
    _phoneCtrl = TextEditingController(text: s?.phone);
    _emailCtrl = TextEditingController(text: s?.email);
    _descriptionCtrl = TextEditingController(text: s?.description);
    _imagePath = s?.photoUrl;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Shop Photo',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pickerOption(Iconsax.camera, 'Camera', () {
                  context.pop();
                  _pickImage(ImageSource.camera);
                }),
                _pickerOption(Iconsax.gallery, 'Gallery', () {
                  context.pop();
                  _pickImage(ImageSource.gallery);
                }),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _pickerOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.coolGrey.withAlpha(50)),
            ),
            child: Icon(icon, color: AppColors.black, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newShop = ChemistShopModel(
        id:
            widget.shopToEdit?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text,
        address: _addressCtrl.text,
        phone: _phoneCtrl.text,
        email: _emailCtrl.text,
        description: _descriptionCtrl.text,
        photoUrl: _imagePath,
      );

      if (widget.shopToEdit == null) {
        ref.read(chemistShopNotifierProvider.notifier).addShop(newShop);
      } else {
        ref.read(chemistShopNotifierProvider.notifier).updateShop(newShop);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.shopToEdit != null;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.chemist);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: isEditing ? 'Edit Chemist Shop' : 'Add New Chemist Shop',
          subtitle: isEditing
              ? 'Update shop details'
              : 'Register a new pharmacy partner',
          showBackButton: true,
          showDrawerButton: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.black.withAlpha(30),
                            width: 2,
                          ),
                          image: _imagePath != null
                              ? DecorationImage(
                                  image: _imagePath!.startsWith('http')
                                      ? NetworkImage(_imagePath!)
                                      : FileImage(File(_imagePath!))
                                            as ImageProvider,
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _imagePath == null
                            ? const Icon(
                                Iconsax.hospital,
                                size: 40,
                                color: AppColors.coolGrey,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Iconsax.camera,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildField('Shop Name', Iconsax.shop, _nameCtrl),
                AppGaps.mediumV,
                _buildField(
                  'Store Address',
                  Iconsax.location,
                  _addressCtrl,
                  maxLines: 2,
                ),
                AppGaps.mediumV,
                _buildField('Phone Number', Iconsax.call, _phoneCtrl),
                AppGaps.mediumV,
                _buildField('Email Address', Iconsax.sms, _emailCtrl),
                AppGaps.mediumV,
                _buildField(
                  'Store Description',
                  Iconsax.document_text,
                  _descriptionCtrl,
                  maxLines: 3,
                ),
                AppGaps.extraLargeV,
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      isEditing ? 'UPDATE SHOP PROFILE' : 'SAVE SHOP PROFILE',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                AppGaps.extraLargeV,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    IconData icon,
    TextEditingController ctrl, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.black, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
