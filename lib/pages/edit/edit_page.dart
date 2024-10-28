import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';
import 'package:forms_tutorial/pages/edit/cubit/edit_cubit.dart';
import 'package:forms_tutorial/pages/edit/views/edit_view.dart';
import 'package:forms_tutorial/pages/profile/profile_page.dart';

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({super.key, required this.user});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCubit(),
      child: BlocConsumer<EditCubit, EditState>(
        listener: (context, state) {
          if (state is SavedState) {
            
            // return to profile page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: state.user)),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case EditErrorState():
            case EditLoadedState():
              return EditPageView(user: (state as EditLoadedState).user);
            case EditInitialState():
            default:
              return EditPageView(user: widget.user);
        }
        }
      )
    );
  }
}