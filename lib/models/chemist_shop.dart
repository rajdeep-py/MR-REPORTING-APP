class ChemistShopModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final String phone;
  final String email;
  final String? photoUrl;

  ChemistShopModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.phone,
    required this.email,
    this.photoUrl,
  });

  ChemistShopModel copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    String? phone,
    String? email,
    String? photoUrl,
  }) {
    return ChemistShopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
