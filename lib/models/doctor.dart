class DoctorChamber {
  final String name;
  final String address;
  final String phone;

  DoctorChamber({
    required this.name,
    required this.address,
    required this.phone,
  });
}

class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String experience;
  final String qualification;
  final String birthday;
  final String description;
  final String phone;
  final String email;
  final String address;
  final String? photoUrl;
  final List<DoctorChamber> chambers;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.qualification,
    required this.birthday,
    required this.description,
    required this.phone,
    required this.email,
    required this.address,
    this.photoUrl,
    required this.chambers,
  });

  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialization,
    String? experience,
    String? qualification,
    String? birthday,
    String? description,
    String? phone,
    String? email,
    String? address,
    String? photoUrl,
    List<DoctorChamber>? chambers,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      qualification: qualification ?? this.qualification,
      birthday: birthday ?? this.birthday,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      photoUrl: photoUrl ?? this.photoUrl,
      chambers: chambers ?? this.chambers,
    );
  }
}
