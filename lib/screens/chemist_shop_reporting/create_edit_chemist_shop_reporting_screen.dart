import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../models/chemist_shop_reporting.dart';
import '../../models/chemist_shop.dart';
import '../../notifiers/chemist_shop_reporting_notifier.dart';
import '../../notifiers/chemist_shop_notifier.dart';

class CreateEditChemistShopReportingScreen extends ConsumerStatefulWidget {
  final ChemistShopReportingModel? reportToEdit;

  const CreateEditChemistShopReportingScreen({super.key, this.reportToEdit});

  @override
  ConsumerState<CreateEditChemistShopReportingScreen> createState() =>
      _CreateEditChemistShopReportingScreenState();
}

class _CreateEditChemistShopReportingScreenState
    extends ConsumerState<CreateEditChemistShopReportingScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateCtrl;
  late TextEditingController _timeCtrl;
  ChemistShopModel? _selectedShop;

  @override
  void initState() {
    super.initState();
    final r = widget.reportToEdit;
    _dateCtrl = TextEditingController(
      text: r?.date ?? DateTime.now().toIso8601String().split('T')[0],
    );
    _timeCtrl = TextEditingController(text: r?.time ?? '11:30 AM');
    _selectedShop = r?.chemistShop;
  }

  @override
  void dispose() {
    _dateCtrl.dispose();
    _timeCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate() && _selectedShop != null) {
      final newReport = ChemistShopReportingModel(
        id:
            widget.reportToEdit?.id ??
            DateTime.now().millisecondsSinceEpoch.toString().substring(5),
        chemistShop: _selectedShop!,
        date: _dateCtrl.text,
        time: _timeCtrl.text,
        productsInterested: widget.reportToEdit?.productsInterested ?? '',
        productsNeeded: widget.reportToEdit?.productsNeeded ?? '',
        status: widget.reportToEdit?.status ?? ChemistReportingStatus.pending,
      );

      if (widget.reportToEdit == null) {
        ref
            .read(chemistReportingNotifierProvider.notifier)
            .addReport(newReport);
      } else {
        ref
            .read(chemistReportingNotifierProvider.notifier)
            .updateReport(newReport);
      }
      context.pop();
    } else if (_selectedShop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a chemist shop')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chemistShops = ref.watch(chemistShopNotifierProvider).allShops;
    final bool isEditing = widget.reportToEdit != null;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.chemistReporting);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: isEditing ? 'Edit Pharmacy Report' : 'New Pharmacy Report',
          subtitle: isEditing
              ? 'Update your visit log'
              : 'Document a chemist shop visit',
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
                _buildSectionTitle(context, 'SELECT CHEMIST SHOP'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ChemistShopModel>(
                      isExpanded: true,
                      hint: const Text('Select a Shop'),
                      value: _selectedShop,
                      items: chemistShops
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(
                                s.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _selectedShop = val),
                    ),
                  ),
                ),
                AppGaps.largeV,

                _buildSectionTitle(context, 'VISIT TIMING'),
                Row(
                  children: [
                    Expanded(
                      child: _buildField('Date', Iconsax.calendar, _dateCtrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField('Time', Iconsax.timer, _timeCtrl),
                    ),
                  ],
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
