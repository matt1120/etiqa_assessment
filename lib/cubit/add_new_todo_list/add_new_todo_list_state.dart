part of 'add_new_todo_list_cubit.dart';

@immutable
abstract class AddNewTodoListState {}

class AddNewTodoListInitial extends AddNewTodoListState {}

class AddNewTodoListSuccess extends AddNewTodoListState {}

class AddNewTodoListFail extends AddNewTodoListState {}
