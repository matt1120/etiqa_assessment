import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_maybank_assessment/db/tododb.dart';
import 'package:flutter_maybank_assessment/model/todo_list_model.dart';
import 'package:meta/meta.dart';

part 'read_todo_list_state.dart';

class ReadTodoListCubit extends Cubit<ReadTodoListState> {
  ReadTodoListCubit() : super(ReadTodoListInitial());

  Future<void> readTodoList() async {
    try {
      final result = await TodoDB.instance.readData();
      List<TodoList> todos = (json.decode(result) as List)
          .map((item) => TodoList.fromJson(item))
          .toList();
      emit(ReadTodoListSuccess(todoList: todos));
    } catch (e) {
      emit(ReadTodoListFailure());
      log(e.toString());
    }
  }
}
