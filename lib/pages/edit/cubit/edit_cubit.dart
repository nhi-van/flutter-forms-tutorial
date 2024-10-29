import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitialState(User.empty()));

  void init() async {
  }

  void onChanges(User user){   
    emit(EditLoadedState(user));
  }

  void saveChanges(User user) {
    User userModified = user.duplicate();
    emit(SavedState(userModified)); 
  }
}


