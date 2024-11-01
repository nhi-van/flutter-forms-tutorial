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

extension UniversityStatusExtension on UniversityStatus {
  String get getStatus {
    switch (this) {
      case UniversityStatus.professor:
        return 'Professor';
      case UniversityStatus.staff:
        return 'Staff';
      case UniversityStatus.student:    
      default:
        return 'Student';
    }
  }
}
```

Then we create our `Radio` button for each status. Below is an example for Student.

```dart
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
```

The radio widget is nested inside a `ListTile`. Notice how `Radio` is a stateless widget, and has these properties:

* `groupValue`: value of the currently selected. Here, the `universityStatus` from our user profile determines which radio should be selected among the three radios.
* `value`: value represented by the radio.
* `onChanged`: callback when the user selects the button. Here the widget responds by updating the user's new status, using cubit.

The radio is selected when `groupValue` and `value` match.

### Checkbox

Checkboxes are used when users need to select multiple, non-exclusive options. In Flutter, checkboxes are implemented using the `Checkbox` widget within a form. Below is an example of how to build and manage checkboxes in a form with three dietary restriction options: Vegetarian, Vegan, and Gluten-Free.

```dart
bool _isVegetarian = false;
bool _isVegan = false;
bool _isGlutenFree = false;

CheckboxListTile(
  title: const Text("Vegetarian"),
  value: _isVegetarian,
  onChanged: (value) {
    setState(() {
      _isVegetarian = value!;
    });
  },
),
CheckboxListTile(
  title: const Text("Vegan"),
  value: _isVegan,
  onChanged: (value) {
    setState(() {
      _isVegan = value!;
    });
  },
),
CheckboxListTile(
  title: const Text("Gluten-Free"),
  value: _isGlutenFree,
  onChanged: (value) {
    setState(() {
      _isGlutenFree = value!;
    });
  },
),
```

Each `CheckboxListTile` widget creates a checkbox with an associated label and keeps track of its state.

#### Checkbox Components Explained

- **`value`**: Represents the current state of the checkbox (checked or unchecked). This should be a boolean variable.
- **`onChanged`**: Callback function that updates the state when the checkbox is checked or unchecked. Here, we use `setState` to update the checkbox state when it’s toggled.

### Integrating Checkboxes into the Form

To incorporate checkboxes into a `Form`, ensure each checkbox’s state is saved upon form submission. Here’s how we can integrate it:

```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the checkbox values as needed
      final dietaryRestrictions = {
        "Vegetarian": _isVegetarian,
        "Vegan": _isVegan,
        "Gluten-Free": _isGlutenFree,
      };
      print(dietaryRestrictions); // or save to the user model
    }
  },
  child: const Text('Save'),
),
```

With this setup, checkboxes allow users to select dietary preferences, with each selection saved in the form. This approach is useful for any form where multiple non-exclusive selections are needed.

However, a **better way to implement checkboxes** would be using Using a `Map<String, bool>` for checkboxes lets you manage each checkbox label and its checked state in a single structure, making it easier to render and update them. Instead of creating separate variables, you define the checkboxes as key-value pairs (e.g., `{ "Vegetarian": false, "Vegan": false }`). In your `build` method, you loop through the map keys to dynamically create `CheckboxListTile` widgets. When a checkbox state changes, you update the corresponding map entry, and you can save all checkbox values at once by accessing the map directly. This approach is cleaner, easier to scale, and simplifies managing checkbox states.

### DropdownButton

This Flutter code implements a dropdown menu that allows users to select their academic major from a predefined list of options.

1. **DropdownMenu`<String>`**:

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

In more complex applications, you might need multiple forms on the same page, each handling different information. For example, one form could handle personal details, while another form captures dietary preferences. To keep things organized, you can use a separate `GlobalKey<FormState>` for each form, which allows you to manage their validations and submissions independently.

Here’s a simple example of setting up two forms, each with its own `GlobalKey`:

```dart
final _basicInfoFormKey = GlobalKey<FormState>();
final _preferencesFormKey = GlobalKey<FormState>();

// Basic Information Form
Form(
  key: _basicInfoFormKey,
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'First Name'),
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Last Name'),
      ),
    ],
  ),
),

// Dietary Preferences Form
Form(
  key: _preferencesFormKey,
  child: Column(
    children: [
      CheckboxListTile(
        title: const Text("Vegetarian"),
        value: _isVegetarian,
        onChanged: (value) {
          setState(() {
            _isVegetarian = value!;
          });
        },
      ),
      CheckboxListTile(
        title: const Text("Vegan"),
        value: _isVegan,
        onChanged: (value) {
          setState(() {
            _isVegan = value!;
          });
        },
      ),
    ],
  ),
),
```

To submit each form separately, validate and save them using the respective keys:

```dart
void _submitForms() {
  if (_basicInfoFormKey.currentState!.validate()) {
    _basicInfoFormKey.currentState!.save();
    // Process basic info
  }

  if (_preferencesFormKey.currentState!.validate()) {
    _preferencesFormKey.currentState!.save();
    // Process dietary preferences
  }
}
```

This approach helps keep form sections independent, which is useful in larger forms that capture different types of information.

## Other References

Here are some resources to learn more about working with forms in Flutter:

- **Flutter Docs**: The [official Flutter documentation](https://flutter.dev/docs) provides examples and guides on forms, fields, and validation.
  
- **Flutter Widget Catalog**: Check out the [widget catalog](https://flutter.dev/docs/development/ui/widgets) to learn about new widgets for building user interfaces.

- **Dart Language Guide**: The [Dart language guide](https://dart.dev/guides) is useful for understanding Dart’s structure and syntax, which powers Flutter apps.

- **Flutter Form Validation Tutorial**: Explore the [Flutter Form Validation Tutorial](https://flutter.dev/docs/cookbook/forms/validation) for tips on managing user input.

These resources can help you understand and make the most of Flutter’s form capabilities in your apps.
