import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/doctor.dart';
import '../../notifiers/doctor_notifier.dart';

class AddEditDoctorScreen extends ConsumerStatefulWidget {
  final DoctorModel? doctorToEdit;

  const AddEditDoctorScreen({super.key, this.doctorToEdit});

  @override
  ConsumerState<AddEditDoctorScreen> createState() =>
      _AddEditDoctorScreenState();
}

class _AddEditDoctorScreenState extends ConsumerState<AddEditDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _specializationCtrl;
  late TextEditingController _experienceCtrl;
  late TextEditingController _qualificationCtrl;
  late TextEditingController _birthdayCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _addressCtrl;
  String? _imagePath;
  List<DoctorChamber> _chambers = [];

  @override
  void initState() {
    super.initState();
    final d = widget.doctorToEdit;
    _nameCtrl = TextEditingController(text: d?.name);
    _specializationCtrl = TextEditingController(text: d?.specialization);
    _experienceCtrl = TextEditingController(text: d?.experience);
    _qualificationCtrl = TextEditingController(text: d?.qualification);
    _birthdayCtrl = TextEditingController(text: d?.birthday);
    _descriptionCtrl = TextEditingController(text: d?.description);
    _phoneCtrl = TextEditingController(text: d?.phone);
    _emailCtrl = TextEditingController(text: d?.email);
    _addressCtrl = TextEditingController(text: d?.address);
    _imagePath = d?.photoUrl;
    _chambers = d?.chambers != null ? List.from(d!.chambers) : [];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _specializationCtrl.dispose();
    _experienceCtrl.dispose();
    _qualificationCtrl.dispose();
    _birthdayCtrl.dispose();
    _descriptionCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
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
              'Select Photo Source',
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

  void _showChamberDialog({DoctorChamber? chamber, int? index}) {
    final nameCtrl = TextEditingController(text: chamber?.name);
    final addressCtrl = TextEditingController(text: chamber?.address);
    final phoneCtrl = TextEditingController(text: chamber?.phone);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => Center(
        child: FadeInUp(
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.black.withAlpha(10),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Iconsax.hospital,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        chamber == null ? 'Add Chamber' : 'Edit Chamber',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildDialogField('Chamber Name', Iconsax.building, nameCtrl),
                  const SizedBox(height: 16),
                  _buildDialogField(
                    'Full Address',
                    Iconsax.location,
                    addressCtrl,
                  ),
                  const SizedBox(height: 16),
                  _buildDialogField('Contact Phone', Iconsax.call, phoneCtrl),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => context.pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(
                              color: AppColors.coolGrey,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameCtrl.text.isNotEmpty) {
                              final newChamber = DoctorChamber(
                                name: nameCtrl.text,
                                address: addressCtrl.text,
                                phone: phoneCtrl.text,
                              );
                              setState(() {
                                if (index == null) {
                                  _chambers.add(newChamber);
                                } else {
                                  _chambers[index] = newChamber;
                                }
                              });
                              context.pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'SAVE',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogField(
    String label,
    IconData icon,
    TextEditingController ctrl,
  ) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.black, size: 18),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newDoctor = DoctorModel(
        id:
            widget.doctorToEdit?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text,
        specialization: _specializationCtrl.text,
        experience: _experienceCtrl.text,
        qualification: _qualificationCtrl.text,
        birthday: _birthdayCtrl.text,
        description: _descriptionCtrl.text,
        phone: _phoneCtrl.text,
        email: _emailCtrl.text,
        address: _addressCtrl.text,
        photoUrl: _imagePath,
        chambers: _chambers,
      );

      if (widget.doctorToEdit == null) {
        ref.read(doctorNotifierProvider.notifier).addDoctor(newDoctor);
      } else {
        ref.read(doctorNotifierProvider.notifier).updateDoctor(newDoctor);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.doctorToEdit != null;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.doctors);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: isEditing ? 'Edit Doctor' : 'Add New Doctor',
          subtitle: isEditing
              ? 'Update professional profile'
              : 'Create a new medical contact',
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
                // Image Picker Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
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
                                Iconsax.user,
                                size: 48,
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
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Text(
                  'BASIC INFORMATION',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildField('Full Name', Iconsax.user, _nameCtrl),
                AppGaps.mediumV,
                _buildField(
                  'Specialization',
                  Iconsax.award,
                  _specializationCtrl,
                ),
                AppGaps.mediumV,
                _buildField(
                  'Experience (e.g. 10 Years)',
                  Iconsax.timer_1,
                  _experienceCtrl,
                ),
                AppGaps.mediumV,
                _buildField(
                  'Qualification',
                  Iconsax.teacher,
                  _qualificationCtrl,
                ),
                AppGaps.mediumV,
                _buildField(
                  'Birthday (e.g. 12th Aug)',
                  Iconsax.cake,
                  _birthdayCtrl,
                ),
                AppGaps.largeV,

                Text(
                  'CONTACT DETAILS',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildField('Personal Phone', Iconsax.call, _phoneCtrl),
                AppGaps.mediumV,
                _buildField('Email Address', Iconsax.sms, _emailCtrl),
                AppGaps.mediumV,
                _buildField(
                  'Residential Address',
                  Iconsax.location,
                  _addressCtrl,
                ),
                AppGaps.largeV,

                Text(
                  'PROFESSIONAL OVERVIEW',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildField(
                  'Description/Overview',
                  Iconsax.document_text,
                  _descriptionCtrl,
                  maxLines: 3,
                ),
                AppGaps.largeV,

                // Chambers Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CHAMBERS',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _showChamberDialog(),
                      icon: const Icon(Iconsax.add_circle, size: 18),
                      label: const Text('Add Chamber'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_chambers.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.coolGrey.withAlpha(30),
                      ),
                    ),
                    child: const Text(
                      'No chambers added yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.coolGrey, fontSize: 12),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _chambers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final chamber = _chambers[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.coolGrey.withAlpha(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.hospital,
                              color: AppColors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chamber.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    chamber.address,
                                    style: const TextStyle(
                                      color: AppColors.coolGrey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => _showChamberDialog(
                                chamber: chamber,
                                index: index,
                              ),
                              icon: const Icon(
                                Iconsax.edit_2,
                                size: 18,
                                color: AppColors.coolGrey,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  setState(() => _chambers.removeAt(index)),
                              icon: const Icon(
                                Iconsax.trash,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                      isEditing
                          ? 'UPDATE DOCTOR PROFILE'
                          : 'SAVE DOCTOR PROFILE',
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
