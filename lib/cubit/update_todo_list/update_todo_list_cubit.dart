import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_maybank_assessment/db/tododb.dart';
import 'package:meta/meta.dart';

part 'update_todo_list_state.dart';

class UpdateTodoListCubit extends Cubit<UpdateTodoListState> {
  UpdateTodoListCubit() : super(UpdateTodoListInitial());

  Future<void> updateToList(
      int id, String todoTitle, String startDate, String endDate) async {
    try {
      final result =
          await TodoDB.instance.update(todoTitle, startDate, endDate, id);
      if (result == "success") {
        emit(UpdateTodoListSuccess());
      } else {
        emit(UpdateTodoListError());
      }
    } catch (e) {
      emit(UpdateTodoListError());
      log(e.toString());
    }
  }
}
