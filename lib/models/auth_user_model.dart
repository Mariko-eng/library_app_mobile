class UserModel {
  String id;
  String name;
  String email;
  String userType;
  String schoolId;
  String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.schoolId,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      userType: json["user_type"],
      schoolId: json["school_id"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
    );
  }
}
