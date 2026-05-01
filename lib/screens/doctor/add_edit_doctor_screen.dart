import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/doctor.dart';
import '../../notifiers/doctor_notifier.dart';

class AddEditDoctorScreen extends ConsumerStatefulWidget {
  final DoctorModel? doctorToEdit;

  const AddEditDoctorScreen({super.key, this.doctorToEdit});

  @override
  ConsumerState<AddEditDoctorScreen> createState() => _AddEditDoctorScreenState();
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

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newDoctor = DoctorModel(
        id: widget.doctorToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text,
        specialization: _specializationCtrl.text,
        experience: _experienceCtrl.text,
        qualification: _qualificationCtrl.text,
        birthday: _birthdayCtrl.text,
        description: _descriptionCtrl.text,
        phone: _phoneCtrl.text,
        email: _emailCtrl.text,
        address: _addressCtrl.text,
        chambers: widget.doctorToEdit?.chambers ?? [],
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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: isEditing ? 'Edit Doctor' : 'Add New Doctor',
        subtitle: isEditing ? 'Update professional profile' : 'Create a new medical contact',
        showBackButton: true,
        showDrawerButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField('Full Name', Iconsax.user, _nameCtrl),
              AppGaps.mediumV,
              _buildField('Specialization', Iconsax.award, _specializationCtrl),
              AppGaps.mediumV,
              _buildField('Experience (e.g. 10 Years)', Iconsax.timer_1, _experienceCtrl),
              AppGaps.mediumV,
              _buildField('Qualification', Iconsax.teacher, _qualificationCtrl),
              AppGaps.mediumV,
              _buildField('Birthday (e.g. 12th Aug)', Iconsax.cake, _birthdayCtrl),
              AppGaps.mediumV,
              _buildField('Personal Phone', Iconsax.call, _phoneCtrl),
              AppGaps.mediumV,
              _buildField('Email Address', Iconsax.sms, _emailCtrl),
              AppGaps.mediumV,
              _buildField('Residential Address', Iconsax.location, _addressCtrl),
              AppGaps.mediumV,
              _buildField('Description/Overview', Iconsax.document_text, _descriptionCtrl, maxLines: 3),
              AppGaps.extraLargeV,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    isEditing ? 'UPDATE DOCTOR PROFILE' : 'SAVE DOCTOR PROFILE',
                    style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w800, letterSpacing: 1),
                  ),
                ),
              ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, TextEditingController ctrl, {int maxLines = 1}) {
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
