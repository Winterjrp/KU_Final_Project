class UserInfoModel {
  String username;
  String userID;
  UserRoleModel userRole;

  UserInfoModel({
    required this.username,
    required this.userID,
    required this.userRole,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        username: json["username"],
        userID: json["userID"],
        userRole: UserRoleModel.fromJson(json["userRole"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "userID": userID,
        "userRole": userRole.toJson(),
      };
}

class UserRoleModel {
  bool isUserManagementAdmin;
  bool isPetFoodManagementAdmin;

  UserRoleModel({
    required this.isUserManagementAdmin,
    required this.isPetFoodManagementAdmin,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        isUserManagementAdmin: json["isUserManagementAdmin"],
        isPetFoodManagementAdmin: json["isPetFoodManagementAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "isUserManagementAdmin": isUserManagementAdmin,
        "isPetFoodManagementAdmin": isPetFoodManagementAdmin,
      };
}
