part of 'task_bloc.dart';

@immutable
abstract class TaskState {
  @override
  List<Object> get props => [];
}
class NoteInitial extends TaskState {

}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<DoModel> todos;

  TaskLoaded({@required this.todos});

}

class EditTaskState extends TaskState {
  final DoModel model;

  EditTaskState({@required this.model});
}