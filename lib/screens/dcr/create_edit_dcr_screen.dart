import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/dcr.dart';
import '../../models/doctor.dart';
import '../../models/visual_ads.dart';
import '../../notifiers/dcr_notifier.dart';
import '../../notifiers/doctor_notifier.dart';
import '../../notifiers/visual_ads_notifier.dart';

class CreateEditDCRScreen extends ConsumerStatefulWidget {
  final DCRModel? dcrToEdit;

  const CreateEditDCRScreen({super.key, this.dcrToEdit});

  @override
  ConsumerState<CreateEditDCRScreen> createState() =>
      _CreateEditDCRScreenState();
}

class _CreateEditDCRScreenState extends ConsumerState<CreateEditDCRScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _placeCtrl;
  late TextEditingController _dateCtrl;
  late TextEditingController _timeCtrl;
  DoctorModel? _selectedDoctor;
  List<VisualAdModel> _selectedAds = [];

  @override
  void initState() {
    super.initState();
    final d = widget.dcrToEdit;
    _placeCtrl = TextEditingController(text: d?.place);
    _dateCtrl = TextEditingController(
      text: d?.date ?? DateTime.now().toIso8601String().split('T')[0],
    );
    _timeCtrl = TextEditingController(text: d?.time ?? '10:00 AM');
    _selectedDoctor = d?.doctor;
    _selectedAds = d?.visualAds != null ? List.from(d!.visualAds) : [];
  }

  @override
  void dispose() {
    _placeCtrl.dispose();
    _dateCtrl.dispose();
    _timeCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate() && _selectedDoctor != null) {
      final newDcr = DCRModel(
        id:
            widget.dcrToEdit?.id ??
            DateTime.now().millisecondsSinceEpoch.toString().substring(5),
        doctor: _selectedDoctor!,
        place: _placeCtrl.text,
        date: _dateCtrl.text,
        time: _timeCtrl.text,
        visualAds: _selectedAds,
        status: widget.dcrToEdit?.status ?? DCRStatus.pending,
      );

      if (widget.dcrToEdit == null) {
        ref.read(dcrNotifierProvider.notifier).addDCR(newDcr);
      } else {
        ref.read(dcrNotifierProvider.notifier).updateDCR(newDcr);
      }
      context.pop();
    } else if (_selectedDoctor == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a doctor')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctors = ref.watch(doctorNotifierProvider).allDoctors;
    final visualAds = ref.watch(visualAdsNotifierProvider).allAds;
    final bool isEditing = widget.dcrToEdit != null;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.dcr);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: isEditing ? 'Edit DCR' : 'Create New DCR',
          subtitle: isEditing
              ? 'Update your visit report'
              : 'Report a new doctor call',
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
                _buildSectionTitle(context, 'SELECT DOCTOR'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<DoctorModel>(
                      isExpanded: true,
                      hint: const Text('Select a Doctor'),
                      value: _selectedDoctor,
                      items: doctors
                          .map(
                            (d) => DropdownMenuItem(
                              value: d,
                              child: Text(
                                d.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _selectedDoctor = val),
                    ),
                  ),
                ),
                AppGaps.largeV,

                _buildSectionTitle(context, 'VISIT DETAILS'),
                _buildField('Place of Visit', Iconsax.location, _placeCtrl),
                AppGaps.mediumV,
                _buildField('Date (YYYY-MM-DD)', Iconsax.calendar, _dateCtrl),
                AppGaps.mediumV,
                _buildField('Time', Iconsax.timer, _timeCtrl),
                AppGaps.largeV,

                _buildSectionTitle(context, 'SELECT VISUAL ADS TO PRESENT'),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visualAds.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final ad = visualAds[index];
                      final isSelected = _selectedAds.any((a) => a.id == ad.id);
                      return CheckboxListTile(
                        title: Text(
                          ad.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        value: isSelected,
                        activeColor: AppColors.black,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _selectedAds.add(ad);
                            } else {
                              _selectedAds.removeWhere((a) => a.id == ad.id);
                            }
                          });
                        },
                      );
                    },
                  ),
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
                      isEditing ? 'UPDATE REPORT' : 'SUBMIT REPORT',
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, TextEditingController ctrl) {
    return TextFormField(
      controller: ctrl,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.black, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
