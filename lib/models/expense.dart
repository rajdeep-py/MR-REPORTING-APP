enum ExpenseStatus { pending, received, rejected }

class ExpenseItem {
  final String title;
  final double amount;

  ExpenseItem({required this.title, required this.amount});
}

class ExpenseModel {
  final String id;
  final DateTime date;
  final List<ExpenseItem> items;
  final List<String> proofImages;
  final ExpenseStatus status;

  ExpenseModel({
    required this.id,
    required this.date,
    required this.items,
    required this.proofImages,
    this.status = ExpenseStatus.pending,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.amount);

  ExpenseModel copyWith({
    String? id,
    DateTime? date,
    List<ExpenseItem>? items,
    List<String>? proofImages,
    ExpenseStatus? status,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      date: date ?? this.date,
      items: items ?? this.items,
      proofImages: proofImages ?? this.proofImages,
      status: status ?? this.status,
    );
  }
}
