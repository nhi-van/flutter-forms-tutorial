import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:forms_tutorial/model/user.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitialState(User.empty()));

  void init() async {
  }
  
  // data changes 
  void onChangeOfFirstName(){
    //current state
    final editState = state as EditModifyingState;
    User user = editState.user.duplicate();

    // validate data

    emit(EditModifyingState(user));
  }

  void saveChanges() {
    final editState = state as EditModifyingState;

    User user = editState.user.duplicate();
    emit(SavedState(user)); 
  }
}


