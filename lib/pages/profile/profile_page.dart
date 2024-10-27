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
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Profile'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'User Information:',
            ),
             Text(widget.user.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditPage(user: widget.user)),
          ).then((value) {
              setState(() {});
          });
        },
        tooltip: 'Edit Profile Information',
        child: const Icon(Icons.edit),
      ),
    );
  }
}