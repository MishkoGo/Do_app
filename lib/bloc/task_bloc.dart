import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../models/do_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskLoading()) {
    on<LoadTask>(_onLoadTodos);
    on<AddTaskEvent>(_onAddEvent);
    on<DeleteTaskEven>(_onDeleteEvent);
    on<UpdateTaskEven>(_onUpdateEvent);
  }

  void _onLoadTodos(LoadTask event, Emitter<TaskState> emit){
    emit(
      TaskLoaded(todos: event.todos),
    );
  }

  void _onAddEvent(AddTaskEvent event, Emitter<TaskState> emit){
    final state = this.state;
    if(state is TaskLoaded) {
      emit(
        TaskLoaded(
          todos: List.from(state.todos)..add(event.model),
          ),
      );
    }
  }

  void _onDeleteEvent(DeleteTaskEven event, Emitter<TaskState> emit){
    final state = this.state;
    if (state is TaskLoaded) {
      emit(
        TaskLoaded(
          todos: List.from(state.todos)..remove,
        ),
      );
    }
  }

  void _onUpdateEvent(UpdateTaskEven event, Emitter<TaskState> emit){
    final state = this.state;
    if(state is TaskLoaded) {
      emit(
        TaskLoaded(
          todos: List.from(state.todos)..remove,
        ),
      );
      emit(
        TaskLoaded(
          todos: List.from(state.todos)..add(event.model),
        ),
      );  
    }
  }
}
