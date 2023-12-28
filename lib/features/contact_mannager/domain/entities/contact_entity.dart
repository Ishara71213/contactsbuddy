import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? id;
  final String? mobile;
  final String? imagePath;
  final DateTime? createdDate;
  final int? createdUser;

  const ContactEntity(
      {this.firstName,
      this.lastName,
      this.email,
      this.id,
      this.mobile,
      this.imagePath,
      this.createdDate,
      this.createdUser});

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        id,
        mobile,
        imagePath,
        createdDate,
        createdUser
      ];
}
