part of 'edit_cubit.dart';


@immutable 
abstract class EditState {}

final class EditInitialState extends EditState {
  final User user;
  EditInitialState(this.user);
}

final class EditErrorState extends EditState {
}

final class EditLoadedState extends EditState {  
  final User user;
  EditLoadedState(this.user);  
}

final class SavedState extends EditState {
  final User user;
  SavedState(this.user);
}

