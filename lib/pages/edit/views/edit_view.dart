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

  late String? _dropdownValue;
  late User userModified;
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

  // Checkbox boolean values for dietary restrictions

      bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isGlutenFree = false;

  @override
  void initState() {
    super.initState();
    userModified = widget.user.duplicate();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _gpaController.text = userModified.gpa.toString();
    _dropdownValue = userModified.major;
           _isVegetarian = userModified.isVegetarian;
   _isVegan = userModified.isVegan;
   _isGlutenFree = userModified.isGlutenFree;

  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  String? _validateGPA(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a GPA.';
    final doubleValue = double.tryParse(value);
    if (doubleValue == null) return 'Please enter a valid number.';
    if (doubleValue < 0.00 || doubleValue > 4.00) return 'GPA must be between 0.00 and 4.00.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Heading for Personal Information
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Personal Information",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.person),
                          ),
                          labelText: 'First Name *',
                        ),
                        controller: _firstNameController,
                        validator: (value) => value != null && value.isEmpty ? 'Please type your name' : null,
                        onChanged: (value) {
                          userModified.setFirstName(value);
                          context.read<EditCubit>().onChanges(userModified);
                        },
                        onSaved: (value) => userModified.setFirstName(value ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.person),
                          ),
                          labelText: 'Last Name *',
                        ),
                        controller: _lastNameController,
                        validator: (value) => value != null && value.isEmpty ? 'Please type your last name' : null,
                        onChanged: (value) {
                          userModified.setLastName(value);
                          context.read<EditCubit>().onChanges(userModified);
                        },
                        onSaved: (value) => userModified.setLastName(value ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Heading for GPA Section
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Academic Information",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                      controller: _gpaController,
                      decoration: const InputDecoration(
                        labelText: 'Enter GPA (0.00 - 4.00) *',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateGPA,
                      onSaved: (value) {
                        userModified.setGPA(value != null && value.isNotEmpty ? double.parse(value) : 0.0);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Heading for University Status
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "University Status",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    title: Text(UniversityStatus.student.getStatus),
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
                    title: Text(UniversityStatus.professor.getStatus),
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
                    title: Text(UniversityStatus.staff.getStatus),
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

                  // Heading for Major Selection
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Select Major",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DropdownMenu<String>(
                    initialSelection: _dropdownValue,
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
                          enabled: true,
                          style: MenuItemButton.styleFrom(foregroundColor: Colors.black),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Heading for Dietary Restrictions
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Dietary Restrictions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CheckboxListTile(
  title: const Text("Vegetarian"),
  value: _isVegetarian,
  onChanged: (value) {
    setState(() {
      _isVegetarian = value!;
      userModified.setisVegetarian(value); // Pass value to the setter
      context.read<EditCubit>().onChanges(userModified);
    });
  },
),
CheckboxListTile(
  title: const Text("Vegan"),
  value: _isVegan,
  onChanged: (value) {
    setState(() {
      _isVegan = value!;
      userModified.setisVegan(value); // Pass value to the setter
      context.read<EditCubit>().onChanges(userModified);
    });
  },
),
CheckboxListTile(
  title: const Text("Gluten-Free"),
  value: _isGlutenFree,
  onChanged: (value) {
    setState(() {
      _isGlutenFree = value!;
      userModified.setisGlutenFree(value); // Pass value to the setter
      context.read<EditCubit>().onChanges(userModified);
    });
  },
),

                  // Save and Cancel Buttons
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
