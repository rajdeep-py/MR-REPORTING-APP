class AttendanceModel {
  final DateTime date;
  final bool isPresent;
  final String? checkIn;
  final String? checkOut;
  final String? breakIn;
  final String? breakOut;

  AttendanceModel({
    required this.date,
    required this.isPresent,
    this.checkIn,
    this.checkOut,
    this.breakIn,
    this.breakOut,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      date: DateTime.parse(json['date']),
      isPresent: json['isPresent'],
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      breakIn: json['breakIn'],
      breakOut: json['breakOut'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'isPresent': isPresent,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'breakIn': breakIn,
      'breakOut': breakOut,
    };
  }
}
