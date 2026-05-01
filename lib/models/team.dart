class TeamMember {
  final String id;
  final String name;
  final String phone;
  final String? photoUrl;

  TeamMember({
    required this.id,
    required this.name,
    required this.phone,
    this.photoUrl,
  });
}

class TeamModel {
  final String id;
  final String name;
  final int membersCount;
  final String description;
  final String? photoUrl;
  final double monthlyTarget;
  final List<String> areasOfWork;
  final List<TeamMember> members;

  TeamModel({
    required this.id,
    required this.name,
    required this.membersCount,
    required this.description,
    this.photoUrl,
    required this.monthlyTarget,
    required this.areasOfWork,
    required this.members,
  });
}
