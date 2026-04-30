class UserModel {
  final String id;
  final String name;
  final String phone;
  final String role;
  final String? profilePic;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role,
      'profilePic': profilePic,
    };
  }
}
