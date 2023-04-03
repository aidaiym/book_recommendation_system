class User {
  String name;
  int age;
  String sex;
  String email;
  bool isAdmin;

  User({
    required this.name,
    required this.age,
    required this.sex,
    required this.email,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'sex': sex,
      'email': email,
      'isAdmin': isAdmin,
    };
  }
}
