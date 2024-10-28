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
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    User userModified = widget.user.duplicate();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;

    // init state. if changed, load loadedState
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
                    onChanged: (value){
                      userModified.setFirstName(value.toString());
                      context.read<EditCubit>().onChanges(userModified);
                    },
                    onSaved: (value) {
                      userModified.setFirstName(value.toString());
                    }
                  ), 
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),            
                      labelText: 'Last Name *',
                    ),                    
                    controller: _lastNameController,
                    validator: (value) {
                      return (value != null && value.isEmpty) ? 'Please type your last name' : null;
                    },
                    onChanged: (value){
                      userModified.setLastName(value.toString());
                      context.read<EditCubit>().onChanges(userModified);
                    },
                    onSaved: (value) {
                      userModified.setLastName(value.toString());
                    }
                  ),    
                  const SizedBox(height: 15),
                  ListTile(
                    title: const Text('Student'),
                    leading: Radio<UniversityStatus>(
                      value: UniversityStatus.student,
                      groupValue: userModified.universityStatus,
                      onChanged: (UniversityStatus? value) => setState( () {
                        userModified.universityStatus = value!;
                        context.read<EditCubit>().onChanges(userModified);
                      }
                      ),
                    ),
                  ),    
                  ListTile(
                    title: const Text('Professor'),
                    leading: Radio<UniversityStatus>(
                      value: UniversityStatus.professor,
                      groupValue: userModified.universityStatus,
                      onChanged: (UniversityStatus? value) {
                        setState(() {
                          userModified.universityStatus = value!;
                          context.read<EditCubit>().onChanges(userModified);
                        });
                      },
                    ),
                  ), 
                  ListTile(
                    title: const Text('Staff'),
                    leading: Radio<UniversityStatus>(
                      value: UniversityStatus.staff,
                      groupValue: userModified.universityStatus,
                      onChanged: (UniversityStatus? value) {
                        setState(() {
                          userModified.universityStatus = value!;
                          context.read<EditCubit>().onChanges(userModified);
                        });
                      },
                    ),
                  ),                                                                                    
                  // Save Button
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