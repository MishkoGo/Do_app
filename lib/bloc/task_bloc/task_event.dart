part of 'task_bloc.dart';

abstract class TaskEvent {

  const TaskEvent([List props = const []]);
}

class NoteInitialEvent extends TaskEvent {
  const NoteInitialEvent() : super();

  @override
  List<Object> get props => [];
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

