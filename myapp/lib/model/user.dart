// users
// int? id;
// String name;
// String email;
// String password;
// String username;
// DateTime createdAt;
// DateTime updatedAt;
// DateTime? deletedAt;
// String? profilePicture;

const String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, name, email, password, username, createdAt, updatedAt, deletedAt,
    profilePicture
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String username = 'username';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String deletedAt = 'deletedAt';
  static const String profilePicture = 'profilePicture';
}

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? profilePicture;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.profilePicture,
  });

  User copy({
    int? id,
    String? name,
    String? email,
    String? password,
    String? username,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? profilePicture,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        profilePicture: profilePicture ?? this.profilePicture,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        name: json[UserFields.name] as String,
        email: json[UserFields.email] as String,
        password: json[UserFields.password] as String,
        username: json[UserFields.username] as String,
        createdAt: DateTime.parse(json[UserFields.createdAt] as String),
        updatedAt: DateTime.parse(json[UserFields.updatedAt] as String),
        deletedAt: json[UserFields.deletedAt] != null
            ? DateTime.parse(json[UserFields.deletedAt] as String)
            : null,
        profilePicture: json[UserFields.profilePicture] as String?,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.password: password,
        UserFields.username: username,
        UserFields.createdAt: createdAt.toIso8601String(),
        UserFields.updatedAt: updatedAt.toIso8601String(),
        UserFields.deletedAt: deletedAt?.toIso8601String(),
        UserFields.profilePicture: profilePicture,
      };
}
