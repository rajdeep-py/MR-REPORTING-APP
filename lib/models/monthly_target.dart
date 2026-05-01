class MonthlyTargetModel {
  final String id;
  final int month; // 1-12
  final int year;
  final double targetAmount;

  MonthlyTargetModel({
    required this.id,
    required this.month,
    required this.year,
    required this.targetAmount,
  });
}
