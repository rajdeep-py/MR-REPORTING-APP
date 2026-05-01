import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/expense_notifier.dart';

final expenseProvider = Provider<ExpenseState>((ref) {
  return ref.watch(expenseNotifierProvider);
});
