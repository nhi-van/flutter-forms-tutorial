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
  final _gpaController = TextEditingController();

  late String? _dropdownValue; // Holds the current selected major
  late User userModified; // Declare userModified as a state variable
  final List<String> majors = [
    'Math',
    'Computer Science',
    'English',
    'Physics',
    'Psychology',
    'Economics',
    'Neuroscience',
    'Accounting',
    'Philosophy',
    'History',
  ];
  // Declare the dropdown value variable
  @override
  void initState() {
    super.initState();
    userModified = widget.user.duplicate(); // Initialize userModified
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _gpaController.text = userModified.gpa.toString(); // Set the initial GPA value

    _dropdownValue = userModified.major; // Assuming user.major holds the current major
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gpaController.dispose(); // Dispose the GPA controller

    super.dispose();
  }

  String? _validateGPA(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a GPA.';
    }
    final doubleValue = double.tryParse(value);
    if (doubleValue == null) {
      return 'Please enter a valid number.';
    }
    if (doubleValue < 0.00 || doubleValue > 4.00) {
      return 'GPA must be between 0.00 and 4.00.';
    }
    return null; // Input is valid
  }

  @override
  Widget build(BuildContext context) {
    User userModified = widget.user.duplicate();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    

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
                    onChanged: (value) {
                      userModified.setFirstName(value.toString());
                      context.read<EditCubit>().onChanges(userModified);
                    },
                    onSaved: (value) {
                      userModified.setFirstName(value.toString());
                    },
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
                    onChanged: (value) {
                      userModified.setLastName(value.toString());
                      context.read<EditCubit>().onChanges(userModified);
                    },
                    onSaved: (value) {
                      userModified.setLastName(value.toString());
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 200, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: TextFormField(
                      controller: _gpaController,
                      decoration: const InputDecoration(
                        labelText: 'Enter GPA (0.00 - 4.00) *',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust padding
                        border: OutlineInputBorder(), // Optional: Gives a bordered effect
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateGPA,
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          userModified.setGPA(double.parse(value));
                        } else {
                          // Handle the case where GPA is not provided, if necessary
                          userModified.setGPA(0.0); // Or throw an error, or whatever logic you need
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 15),
                  ListTile(
                    title: const Text('Student'),
                    leading: Radio<UniversityStatus>(
                      value: UniversityStatus.student,
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

                  
                  DropdownMenu<String>(
                    initialSelection: _dropdownValue,
                    //requestFocusOnTap: true,
                    label: const Text('Select Major'),
                    onSelected: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _dropdownValue = newValue;
                          userModified.setMajor(newValue);
                          context.read<EditCubit>().onChanges(userModified);
                        });
                      }
                    },
                    dropdownMenuEntries: majors.map<DropdownMenuEntry<String>>(
                      (String major) {
                        return DropdownMenuEntry<String>(
                          value: major,
                          label: major,
                          enabled: true, // Change based on your requirements
                          style: MenuItemButton.styleFrom(
                            foregroundColor: Colors.black, // Change as per your color logic
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20),


                  
                  

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

