import 'package:book_recommendation_system/files.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);
  static const String id = 'user_info';

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sexController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final age = int.parse(_ageController.text);
      final sex = _sexController.text;
      final email = AuthenticationService.auth.currentUser!.email;
      final users = User(name: name, age: age, sex: sex, email: email!);
      await FirebaseFirestore.instance.collection('users').add(users.toMap());
      Navigator.pushNamed(context, MainView.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Form')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sexController,
                decoration: const InputDecoration(labelText: 'Sex'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your sex';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
