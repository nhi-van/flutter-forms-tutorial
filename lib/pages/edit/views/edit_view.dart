import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';
import 'package:forms_tutorial/pages/edit/cubit/edit_cubit.dart';
import 'package:provider/provider.dart';

class EditPageView extends StatefulWidget {
  final User user;
  const EditPageView({super.key, required this.user});

  @override
  State<EditPageView> createState() => _EditPageViewState();
}

class _EditPageViewState extends State<EditPageView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User userModified = widget.user.duplicate();
    _firstNameController.text = widget.user.firstName;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(userModified.toString()),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),            
                      labelText: 'First Name *',
                    ),                    
                    controller: _firstNameController,
                    validator: (value) {
                      return (value != null && value.isEmpty) ? 'Please type your name' : null;
                    },
                    onSaved: (value) {
                      userModified.setFirstName(value.toString());
                    }
                  ), 
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // returns true if the validator of all forms is true. displays individual errors messages otherwise                        
                        _formKey.currentState?.save();

                        context.read<EditCubit>().saveChanges(userModified);
                      }
                    }, 
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Text('Cancel'),
                  ),                  
                ],
              )
            ),          
          ],
        ),
      )
    );
  }
}