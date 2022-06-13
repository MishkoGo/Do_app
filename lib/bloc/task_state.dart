part of 'task_bloc.dart';

@immutable
abstract class TaskState {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<DoModel> todos;

  const TaskLoaded({this.todos = const <DoModel>[]});

  @override
  List<Object> get props => [todos];
}

