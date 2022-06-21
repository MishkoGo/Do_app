part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {

  @override
  List<Object> get props => [];
}

class NoteInitialEvent extends TaskEvent {

}

// class LoadTask extends TaskEvent {
//   final List<DoModel> todos;
//
//   LoadTask({this.todos = const <DoModel>[]});
//
//   @override
//   List<Object> get props => [todos];
// }

class AddTaskEvent extends TaskEvent{
  final String model;

  AddTaskEvent({@required this.model});
}

class UpdateTaskEven extends TaskEvent {
  final String title;
  final int index;

  UpdateTaskEven({@required this.index,@required this.title});
}

class DeleteTaskEven extends TaskEvent {
  final int model;

  DeleteTaskEven({@required this.model});

}

