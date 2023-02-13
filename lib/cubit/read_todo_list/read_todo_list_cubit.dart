import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_maybank_assessment/db/tododb.dart';
import 'package:flutter_maybank_assessment/model/todo_list_model.dart';
import 'package:meta/meta.dart';

part 'read_todo_list_state.dart';

class ReadTodoListCubit extends Cubit<ReadTodoListState> {
  ReadTodoListCubit() : super(ReadTodoListInitial());

  void readTodoList() {
    try {
      final result = TodoDB.instance.readData();
      emit(ReadTodoListSuccess(todoList: TodoList.fromJson(result)));
    } catch (e) {
      emit(ReadTodoListFailure());
    }
  }
}
