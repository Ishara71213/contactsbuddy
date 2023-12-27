import 'package:contactsbuddy/core/constants/db_tables.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {final int? id,
      final String? firstName,
      final String? lastName,
      final String? email,
      final DateTime? dob,
      final String? gender,
      final String? mobile,
      final String? password,
      final String? imagePath})
      : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          dob: dob,
          gender: gender,
          mobile: mobile,
          password: password,
          imagePath: imagePath,
        );

  UserModel copy(
          {int? id,
          String? firstName,
          String? lastName,
          String? email,
          DateTime? dob,
          String? gender,
          String? mobile,
          String? password,
          String? imagePath}) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        mobile: mobile ?? this.mobile,
        password: password ?? this.password,
        imagePath: imagePath ?? this.imagePath,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      dob: json['dob'] != null && json['dob'] != ""
          ? DateTime.parse(json['dob'])
          : null,
      gender: json['gender'],
      mobile: json['mobile'],
      password: json['password'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UsersFields.id: id,
      UsersFields.firstName: firstName ?? "",
      UsersFields.lastName: lastName ?? "",
      UsersFields.email: email ?? "",
      UsersFields.dob: dob?.toIso8601String() ?? "",
      UsersFields.gender: gender ?? "",
      UsersFields.mobile: mobile ?? "",
      UsersFields.password: password ?? "",
      UsersFields.imagePath: imagePath ?? "",
    };
  }
}
