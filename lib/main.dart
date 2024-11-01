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
    // Initialize the User with dietary restrictions
    User user = User(
      firstName: 'John', 
      lastName: 'Wick', 
      email: 'jwick@scu.edu', 
      universityStatus: UniversityStatus.student,
      major: 'Math',
      gpa: 4.0,
      isVegetarian: true,      
      isVegan: true,
      isGlutenFree: true,
    );
    
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
