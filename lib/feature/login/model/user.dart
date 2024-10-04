class UserModel {
  String? id;
  String username;
  String password;
  int status;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'status': status,
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      username: map['username'] as String,
      password: map['password'] as String,
      status: map['status'] as int,
    );
  }
}
