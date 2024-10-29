part of 'edit_cubit.dart';


@immutable 
abstract class EditState {}

final class EditInitialState extends EditState {
  final User user;
  EditInitialState(this.user);
  List<Object> get props => [user];
}

final class EditErrorState extends EditState {
}

final class EditLoadedState extends EditState {  
  final User user;
  EditLoadedState(this.user);  
  List<Object> get props => [user];  
}

final class SavedState extends EditState {
  final User user;
  SavedState(this.user);
  List<Object> get props => [user];
}

