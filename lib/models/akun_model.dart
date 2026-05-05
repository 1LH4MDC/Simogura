class AkunModel {
  final int? id;
  final String? username;
  final String? password;
  final String? role;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  AkunModel({
    this.id,
    this.username,
    this.password,
    this.role,
    this.createdAt,
    this.lastLoginAt,
  });

  factory AkunModel.fromJson(Map<String, dynamic> json) {
    return AkunModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      lastLoginAt: json['lastlogin_at'] != null 
          ? DateTime.parse(json['lastlogin_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'created_at': createdAt?.toIso8601String(),
      'lastlogin_at': lastLoginAt?.toIso8601String(),
    };
  }
}
