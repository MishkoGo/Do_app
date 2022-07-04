import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../models/do_model.dart';
import '../../services/todo_database.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TodoDatabase _todoDatabase;
  List<DoModel> _models = [];
  TaskBloc(this._todoDatabase) : super(NoteInitial()) {
    on<NoteInitialEvent>(_onLoadTodos);
    on<AddTaskEvent>(_onAddEvent);
    on<DeleteTaskEven>(_onDeleteEvent);
    on<UpdateTaskEven>(_onUpdateEvent);
  }

  void _onLoadTodos(NoteInitialEvent event, Emitter<TaskState> emit) async{
    TaskLoading();
    await _getNotes();
    emit(
      TaskLoaded(todos: _models),
    );
  }

  void _onAddEvent(AddTaskEvent event, Emitter<TaskState> emit) async{
    TaskLoading();
    await _addToNotes(event.model);
    emit(
        TaskLoaded(todos: _models),
    );

  }

  void _onDeleteEvent(DeleteTaskEven event, Emitter<TaskState> emit,) async{
    TaskLoading();
   await _removeFromNotes(index: event.model);
   emit(
       TaskLoaded(todos: _models),
   );

  }

  void _onUpdateEvent(UpdateTaskEven event, Emitter<TaskState> emit) async{
    TaskLoading();
    await _removeFromNotes(index: event.index);
    await _addToNotes(event.title);
    //await _updateNote(model: event.title, index: event.index);
    emit(
      TaskLoaded(todos: _models),
    );
  }

  Future<void> _getNotes() async {
    await _todoDatabase.getFullNote().then((value) {
      _models = value;
    });
  }

  Future<void> _addToNotes(String model) async {
    await _todoDatabase.addToBox(DoModel(task: model));
    await _getNotes();
  }

  Future<void> _updateNote({int index, String model}) async {
    await _todoDatabase.updateNote(
        index, DoModel(task: model));
    await _getNotes();
  }
  Future<void> _removeFromNotes({int index}) async {
    await _todoDatabase.deleteFromBox(index);
    await _getNotes();
  }
}
