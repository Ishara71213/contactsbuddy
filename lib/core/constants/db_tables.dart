class DbTables {
  static const String users = "users";
}

class UsersFields {
  static final List<String> columns = [
    id,
    firstName,
    lastName,
    email,
    dob,
    gender,
    mobile,
    password,
    imagePath
  ];

  static const String id = "_id";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String dob = "dob";
  static const String gender = "gender";
  static const String mobile = "mobile";
  static const String password = "password";
  static const String imagePath = "imagePath";
}
