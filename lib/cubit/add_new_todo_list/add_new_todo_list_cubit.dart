import 'package:bloc/bloc.dart';
import 'package:flutter_maybank_assessment/db/tododb.dart';
import 'package:meta/meta.dart';

part 'add_new_todo_list_state.dart';

class AddNewTodoListCubit extends Cubit<AddNewTodoListState> {
  AddNewTodoListCubit() : super(AddNewTodoListInitial());

  void insertIntoDatabase(String todoTitle, String startDate, String endDate) {
    TodoDB.instance.insertData(
        todoTitle: todoTitle, startDate: startDate, endDate: endDate, );
  }
}
