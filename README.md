# Forms in Flutter: Introduction to different types

Introduction to Forms in Flutter, and how to use them.

  Table of Contents

- [Introduction](#introduction)
- [General Parts of a Form](#general-parts-of-a-form)
- [Different Types of Forms](#different-types-of-forms)
  - [TextFormField](README.md#textformfield)
  - [Radio](README.md#radio)
  - [Checkbox](README.md#checkbox)
  - [DropdownButton](README.md#dropdownbutton)
  - [Working with Multiple Forms](README.md#working-with-multiple-forms)
- [References](README.md#other-references)

## Introduction

We see the use and application of forms in our everyday lives. Applying for an internship or job online is an example of a form in which it has text fields for you name, email, phone number, university, location, etc. These job apps also rely of radio button, checkboxes, drop-down, and validations in order to capture and process your information for the position.

<img width="1277" alt="Screenshot 2024-10-30 at 9 46 07 AM" src="https://github.com/user-attachments/assets/48920685-6d64-4aab-bc53-004e178e5dd6">

From this example, we can see how a company or anyone could benefit from the use of forms since it provides a structured and organized way to retrieve user data in a way that fit requirements, updates user interface and processes it for some final destination.

Flutter offers a widget, called the “Forms" widget, which allows us to build forms or add functionality in our app that works like a form. For our presentation, we will be going over the general components of Flutter's "Forms" widget and how to build them: TextFormField, Radio, Checkbox, and DropdownButton.

## Different Types of Forms

### TextFormField

A text field is a type of form that takes in user-input text. Here we use a `TextFormField` to take in the user's first name.

```dart
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
```

Officially, a `TextFormField` is a `TextField` widget wrapped inside a `FormField`, and is convenient because it allows validation of our input. Let's take a closer look at its components:

* `controller`:  controls the text being edited. It can be used when `TextFormField` is defined under a scrolling container, such as `ListView` or `SingleChildScrollView`.
* `validator`: in short, checks the input against our requirements. In our example, we require a first name, so if no input is given, we print an error message and ask them to type their name.
* `onChanged`/`onSaved`/`onPressed`: callback functions on those respective conditions.

#### The textfield controller

To use a `controller` with our `TextFormField`, we need to intiallize it before we can use it. 

```dart
class _EditPageViewState extends State<EditPageView> {
  final _firstNameController = TextEditingController();
  ...
}
```

Each `TextFormField` has its own `TextEditingController()`.

Now, let's say our user profile already has a first name filled out. To display it in our textfield preset, we can do so in the initState() of our page.

```dart
  void initState() {
    ...
    _firstNameController.text = widget.user.firstName;
    ...
  }
```

In our code, we have `user` as a parameter for our StatefulWidget, so we would call it using `widget.user`. 

Then once we're done with our form, we need to dispose of the controller.

```dart
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gpaController.dispose(); 

    super.dispose();
  }
```

These controllers are disposed when the widget of our Edit Page is disposed. 

### Radio

The radio button is used when you need to choose between mutually exclusive values, i.e. only one option can be selected at a time. Let's say we want to determine if the user is a student, staff, or professor. First, we determine what values we want our radio buttons to have, using `enum`:

```dart
enum UniversityStatus { student, professor, staff}
```

Then we create our `Radio` button for each status. Below is an example for Student.

```dart
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
```

The radio widget is nested inside a `ListTile`. Notice how `Radio` is a stateless widget, and has these properties:

* `groupValue`: value of the currently selected. Here, the `universityStatus` from our user profile determines which radio should be selected among the three radios.
* `value`: value represented by the radio.
* `onChanged`: callback when the user selects the button. Here the widget responds by updating the user's new status, using cubit.

The radio is selected when `groupValue` and `value` match.

### Checkbox

### DropdownButton

This Flutter code implements a dropdown menu that allows users to select their academic major from a predefined list of options. 

1. **DropdownMenu<String>**: 

This is the main widget, which initializes a dropdown menu that uses a generic type `String`. Here, the dropdown menu displays a list of strings representing various "majors."

```dart
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
        ...
    ).toList(),
),
```
2. **initialSelection**:
The initialSelection property sets the initially selected value in the dropdown. This variable (_dropdownValue) is stored in the widget's state and can be updated when the user selects a new option.

3. **label**:
The label property provides a title or prompt for the dropdown menu. Here, the label is a Text widget that displays "Select Major" to indicate the purpose of the dropdown.

4. **onSelected**:
The onSelected property defines a callback that triggers when a user selects an option from the dropdown.

- Inside this callback, we check if the new value (newValue) is non-null.
- The widget’s state (_dropdownValue) is updated to reflect the selected option.
- Additionally, this example sets the user's major via a custom setMajor method and notifies the application of changes through the EditCubit.

5. **dropdownMenuEntries**:
The dropdownMenuEntries property populates the dropdown with selectable items.

- We map each string in a list called majors to a DropdownMenuEntry object.
- Each entry is assigned a value and label, both of which are set to the major's name.
- Additionally, each item can be customized with various properties, such as enabled (to control availability) and style (for setting color and appearance).

```dart
dropdownMenuEntries: majors.map<DropdownMenuEntry<String>>(
  (String major) {
    return DropdownMenuEntry<String>(
      value: major,
      label: major,
      enabled: true,
      style: MenuItemButton.styleFrom(
        foregroundColor: Colors.black,
      ),
    );
  },
).toList(),
```
1. **Mapping the Majors List**:
   - `majors.map<DropdownMenuEntry<String>>((String major) {...})` takes each `String` item (each major) from the `majors` list and creates a `DropdownMenuEntry<String>` for it.
   - Inside the `map` function, each `major` is converted into a `DropdownMenuEntry<String>` object with properties to customize its appearance and behavior in the dropdown menu.

2. **Creating a DropdownMenuEntry for Each Major**:
   - `DropdownMenuEntry<String>` is created for each item in the `majors` list with the following properties:
     - **value**: This is the actual value represented by the item in the dropdown. Here, it’s set to the major's name (`value: major`).
     - **label**: This is the text that will be shown for each item in the dropdown menu. It’s also set to the major's name (`label: major`).
     - **enabled**: This property controls whether the item is selectable. Here, it’s set to `true`, making all options selectable by default.
     - **style**: Defines the style for the dropdown item. In this example, `MenuItemButton.styleFrom(foregroundColor: Colors.black)` sets the text color of each item to black. You can modify the `foregroundColor` to change how each item’s text color appears.

3. **Converting the Mapped List to List Type**:
   - The `map` function generates an iterable, so calling `.toList()` converts this into a standard list of `DropdownMenuEntry<String>` items. This list is then assigned to `dropdownMenuEntries`, populating the dropdown menu with options.

### Working with Multiple Forms

## Other References
