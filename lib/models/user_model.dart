class User {
  String name;
  int age;
  String sex;
  String email;
  // String role;

  User({
    required this.name,
    required this.age,
    required this.sex,
    required this.email,
    // required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'sex': sex,
      'email': email,
      // 'role': role,
    };
  }
}
