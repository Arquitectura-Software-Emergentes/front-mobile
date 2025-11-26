import '../../domain/entities/user.dart';

//Convierte datos JSON en objetos Dart y viceversa
class UserModel extends User {
  UserModel({
    required String id,
    required String fullName,
    required String email,
    required String userType,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
          userType: userType,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        fullName: json['full_name'],
        email: json['email'] ?? '',
        userType: json['user_type'],
      );
}