import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';

class EditPageView extends StatefulWidget {
  final User user;
  const EditPageView({super.key, required this.user});

  @override
  State<EditPageView> createState() => _EditPageViewState();
}

class _EditPageViewState extends State<EditPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.user.toString()),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),            
                labelText: 'First Name *',
              ),
              validator: (String? value) {
                return (value != null && value.contains('@')) ? 'No @ symbols.' : null;
              },
              //onChanged: CUBIT
            ),            
          ],
        ),
      )
    );
  }
}