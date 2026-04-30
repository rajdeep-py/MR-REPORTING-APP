class UserModel {
  final String id;
  final String name;
  final String phone;
  final String role;
  final String designation;
  final String company;
  final String email;
  final String hq;
  final String areaOfWork;
  final String? altPhone;
  final String? altEmail;
  final String? address;
  final String? password;
  final String? profilePic;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.designation,
    required this.company,
    required this.email,
    required this.hq,
    required this.areaOfWork,
    this.altPhone,
    this.altEmail,
    this.address,
    this.password,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'],
      designation: json['designation'] ?? 'Medical Representative',
      company: json['company'] ?? 'MR Pharma Ltd.',
      email: json['email'] ?? '',
      hq: json['hq'] ?? '',
      areaOfWork: json['areaOfWork'] ?? '',
      altPhone: json['altPhone'],
      altEmail: json['altEmail'],
      address: json['address'],
      password: json['password'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role,
      'designation': designation,
      'company': company,
      'email': email,
      'hq': hq,
      'areaOfWork': areaOfWork,
      'altPhone': altPhone,
      'altEmail': altEmail,
      'address': address,
      'password': password,
      'profilePic': profilePic,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? role,
    String? designation,
    String? company,
    String? email,
    String? hq,
    String? areaOfWork,
    String? altPhone,
    String? altEmail,
    String? address,
    String? password,
    String? profilePic,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      designation: designation ?? this.designation,
      company: company ?? this.company,
      email: email ?? this.email,
      hq: hq ?? this.hq,
      areaOfWork: areaOfWork ?? this.areaOfWork,
      altPhone: altPhone ?? this.altPhone,
      altEmail: altEmail ?? this.altEmail,
      address: address ?? this.address,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}
