import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';
import 'package:forms_tutorial/pages/edit/edit_page.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    // Initialize currentUser with widget.user's values
    currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Center(
              child: Text(
                'User Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ProfileField(label: "First Name", value: currentUser.firstName),
                  const Divider(),
                  ProfileField(label: "Last Name", value: currentUser.lastName),
                  const Divider(),
                  ProfileField(label: "Email", value: currentUser.email),
                  const Divider(),
                  ProfileField(label: "University Status", value: currentUser.universityStatus.getStatus),
                  const Divider(),
                  ProfileField(label: "Major", value: currentUser.major),
                  const Divider(),
                  ProfileField(label: "GPA", value: currentUser.gpa.toStringAsFixed(2)),
                  const Divider(),
                  ProfileField(label: "Vegetarian", value: currentUser.isVegetarian ? "Yes" : "No"),
                  const Divider(),
                  ProfileField(label: "Vegan", value: currentUser.isVegan ? "Yes" : "No"),
                  const Divider(),
                  ProfileField(label: "Gluten-Free", value: currentUser.isGlutenFree ? "Yes" : "No"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Wait for the updated user after editing
          final updatedUser = await Navigator.push<User>(
            context,
            MaterialPageRoute(builder: (context) => EditPage(user: currentUser)),
          );
          if (updatedUser != null) {
            setState(() {
              currentUser = updatedUser; // Update currentUser with the modified user data
            });
          }
        },
        tooltip: 'Edit Profile Information',
        child: const Icon(Icons.edit),
      ),
    );
  }
}

// Widget to display each profile field as a label-value pair
class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
