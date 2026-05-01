class StockistModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final String phone;
  final String email;
  final String? photoUrl;
  final String minOrderValue;
  final String expectedDeliveryTime;
  final String medicinesInterestedIn;

  StockistModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.phone,
    required this.email,
    this.photoUrl,
    required this.minOrderValue,
    required this.expectedDeliveryTime,
    required this.medicinesInterestedIn,
  });

  StockistModel copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    String? phone,
    String? email,
    String? photoUrl,
    String? minOrderValue,
    String? expectedDeliveryTime,
    String? medicinesInterestedIn,
  }) {
    return StockistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      minOrderValue: minOrderValue ?? this.minOrderValue,
      expectedDeliveryTime: expectedDeliveryTime ?? this.expectedDeliveryTime,
      medicinesInterestedIn: medicinesInterestedIn ?? this.medicinesInterestedIn,
    );
  }
}
