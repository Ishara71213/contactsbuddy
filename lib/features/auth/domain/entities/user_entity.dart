import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? id;
  final DateTime? dob;
  final String? gender;
  final String? mobile;
  final String? password;
  final String? confirmPassword;
  final String? imagePath;

  const UserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.id,
    this.dob,
    this.gender,
    this.mobile,
    this.password,
    this.confirmPassword,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        id,
        dob,
        gender,
        mobile,
        password,
        imagePath
      ];
}
