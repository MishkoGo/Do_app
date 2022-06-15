part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {

  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTask extends TaskEvent {
  final List<DoModel> todos;

  const LoadTask({this.todos = const <DoModel>[]});

  @override
  List<Object> get props => [todos];
}

class AddTaskEvent extends TaskEvent{
  final DoModel model;

  const AddTaskEvent({required this.model});

  @override
  List<Object> get props => [model];

}

class UpdateTaskEven extends TaskEvent {
  final DoModel model;

  const UpdateTaskEven({required this.model});

  @override
  List<Object> get props => [model];
}

class DeleteTaskEven extends TaskEvent {
  final DoModel model;

  const DeleteTaskEven({required this.model});

  @override
  List<Object> get props => [model];
}

