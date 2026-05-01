import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/expense_notifier.dart';
import '../../cards/expense/expense_card.dart';
import '../../cards/expense/expense_filter_card.dart';
import '../../cards/expense/expense_details_bottomsheet.dart';
import '../../routes/app_router.dart';
import '../../models/expense.dart';

class MyExpenseScreen extends ConsumerWidget {
  const MyExpenseScreen({super.key});

  void _showExpenseDetails(BuildContext context, ExpenseModel expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExpenseDetailsBottomSheet(expense: expense),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(expenseNotifierProvider);
    final expenseNotifier = ref.read(expenseNotifierProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.home);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: AppRouter.expenses),
        appBar: CustomAppBar(
          title: 'Expense Tracker',
          subtitle: 'Log and track your daily claims',
          showDrawerButton: true,
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: () => context.push(AppRouter.createExpense),
              icon: const Icon(Iconsax.add_square, color: AppColors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Column(
            children: [
              ExpenseFilterCard(
                selectedMonth: expenseState.selectedMonth,
                selectedYear: expenseState.selectedYear,
                onFilterChanged: expenseNotifier.setFilter,
              ),
              AppGaps.largeV,
              if (expenseState.filteredExpenses.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No expenses found for selected period.'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expenseState.filteredExpenses.length,
                  separatorBuilder: (context, index) => AppGaps.mediumV,
                  itemBuilder: (context, index) {
                    final expense = expenseState.filteredExpenses[index];
                    return ExpenseCard(
                      expense: expense,
                      onTap: () => _showExpenseDetails(context, expense),
                    );
                  },
                ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }
}
