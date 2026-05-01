class TeamModel {
  final String id;
  final String name;
  final int membersCount;
  final String description;
  final String? photoUrl;

  TeamModel({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.description,
    this.photoUrl,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      membersCount: json['membersCount'],
      description: json['description'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'membersCount': membersCount,
      'description': description,
      'photoUrl': photoUrl,
    };
  }
}
