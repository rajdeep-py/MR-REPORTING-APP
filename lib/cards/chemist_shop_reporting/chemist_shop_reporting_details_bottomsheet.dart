import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../models/chemist_shop_reporting.dart';
import '../../routes/app_router.dart';

class ChemistShopReportingDetailsBottomSheet extends StatefulWidget {
  final ChemistShopReportingModel report;
  final Function(ChemistShopReportingModel) onUpdate;

  const ChemistShopReportingDetailsBottomSheet({
    super.key,
    required this.report,
    required this.onUpdate,
  });

  @override
  State<ChemistShopReportingDetailsBottomSheet> createState() => _ChemistShopReportingDetailsBottomSheetState();
}

class _ChemistShopReportingDetailsBottomSheetState extends State<ChemistShopReportingDetailsBottomSheet> {
  late TextEditingController _interestedCtrl;
  late TextEditingController _neededCtrl;
  late ChemistReportingStatus _status;

  @override
  void initState() {
    super.initState();
    _interestedCtrl = TextEditingController(text: widget.report.productsInterested);
    _neededCtrl = TextEditingController(text: widget.report.productsNeeded);
    _status = widget.report.status;
  }

  @override
  void dispose() {
    _interestedCtrl.dispose();
    _neededCtrl.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    final updatedReport = widget.report.copyWith(
      productsInterested: _interestedCtrl.text,
      productsNeeded: _neededCtrl.text,
      status: _status,
    );
    widget.onUpdate(updatedReport);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHEMIST SHOP REPORT',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                    ),
                    Text(
                      '#${widget.report.id}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    context.pop();
                    context.push(AppRouter.createEditChemistReporting, extra: widget.report);
                  },
                  icon: const Icon(Iconsax.edit, color: AppColors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  _buildReadOnlyDetail(Iconsax.shop, 'Chemist Shop', widget.report.chemistShop.name),
                  _buildReadOnlyDetail(Iconsax.location, 'Address', widget.report.chemistShop.address),
                  _buildReadOnlyDetail(Iconsax.call, 'Contact No', widget.report.chemistShop.phone),
                  _buildReadOnlyDetail(Iconsax.sms, 'Email', widget.report.chemistShop.email),
                  _buildReadOnlyDetail(Iconsax.calendar, 'Date', widget.report.date),
                  _buildReadOnlyDetail(Iconsax.timer, 'Time', widget.report.time),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(height: 1, thickness: 0.5),
                  ),
                  
                  Text(
                    'PRODUCTS INTERESTED',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  _buildEditableField('e.g. Antibiotics, Vitamins', _interestedCtrl),
                  
                  const SizedBox(height: 24),
                  Text(
                    'PRODUCTS NEEDED',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  _buildEditableField('e.g. Immediate stock for Paracetamol', _neededCtrl),
                  
                  const SizedBox(height: 32),
                  Text(
                    'UPDATE STATUS',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: ChemistReportingStatus.values.map((status) {
                      final isSelected = _status == status;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () => setState(() => _status = status),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.black : AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: isSelected ? AppColors.black : AppColors.coolGrey.withAlpha(30)),
                              ),
                              child: Text(
                                status.name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? AppColors.white : AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleUpdate();
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('SAVE CHANGES', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800)),
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

  Widget _buildReadOnlyDetail(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, color: AppColors.coolGrey, fontWeight: FontWeight.w600)),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String hint, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      maxLines: 2,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
