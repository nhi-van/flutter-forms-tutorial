import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';
import 'package:forms_tutorial/pages/profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User(firstName: 'John', lastName: 'Wick', email: 'email');
    
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ProfilePage(user: user),
    );
  }
}
