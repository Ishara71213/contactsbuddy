import 'package:contactsbuddy/core/constants/db_tables.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    final int? id,
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? mobile,
    final String? imagePath,
    final DateTime? createdDate,
    final int? createdUser,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          mobile: mobile,
          imagePath: imagePath,
          createdDate: createdDate,
          createdUser: createdUser,
        );

  ContactModel copy({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? mobile,
    String? password,
    String? imagePath,
    DateTime? createdDate,
    int? createdUser,
  }) =>
      ContactModel(
        id: id ?? this.id,
        createdUser: createdUser ?? this.createdUser,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        imagePath: imagePath ?? this.imagePath,
        createdDate: createdDate ?? this.createdDate,
      );

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobile: json['mobile'],
      imagePath: json['imagePath'],
      createdDate: json['createdDate'] != null && json['createdDate'] != ""
          ? DateTime.parse(json['createdDate'])
          : null,
      createdUser: json['createdUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ContactsFields.id: id,
      ContactsFields.firstName: firstName ?? "",
      ContactsFields.lastName: lastName ?? "",
      ContactsFields.email: email ?? "",
      ContactsFields.mobile: mobile ?? "",
      ContactsFields.imagePath: imagePath ?? "",
      ContactsFields.createdDate: createdDate?.toIso8601String() ?? "",
      ContactsFields.createdUser: createdUser ?? "",
    };
  }
}
