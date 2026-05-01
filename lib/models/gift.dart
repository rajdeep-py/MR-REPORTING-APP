import 'doctor.dart';

enum GiftStatus { pending, approved, rejected }

class GiftModel {
  final String id;
  final DoctorModel doctor;
  final String occasion;
  final String giftItem;
  final String date; // YYYY-MM-DD
  final GiftStatus status;

  GiftModel({
    required this.id,
    required this.doctor,
    required this.occasion,
    required this.giftItem,
    required this.date,
    this.status = GiftStatus.pending,
  });

  GiftModel copyWith({
    String? id,
    DoctorModel? doctor,
    String? occasion,
    String? giftItem,
    String? date,
    GiftStatus? status,
  }) {
    return GiftModel(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      occasion: occasion ?? this.occasion,
      giftItem: giftItem ?? this.giftItem,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
