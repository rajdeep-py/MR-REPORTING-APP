import 'doctor.dart';
import 'visual_ads.dart';

enum DCRStatus { pending, completed, cancelled }

class DCRModel {
  final String id;
  final DoctorModel doctor;
  final String place;
  final String date; // YYYY-MM-DD
  final String time;
  final List<VisualAdModel> visualAds;
  final DCRStatus status;

  DCRModel({
    required this.id,
    required this.doctor,
    required this.place,
    required this.date,
    required this.time,
    required this.visualAds,
    this.status = DCRStatus.pending,
  });

  DCRModel copyWith({
    String? id,
    DoctorModel? doctor,
    String? place,
    String? date,
    String? time,
    List<VisualAdModel>? visualAds,
    DCRStatus? status,
  }) {
    return DCRModel(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      place: place ?? this.place,
      date: date ?? this.date,
      time: time ?? this.time,
      visualAds: visualAds ?? this.visualAds,
      status: status ?? this.status,
    );
  }
}
