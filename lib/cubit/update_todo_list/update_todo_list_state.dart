part of 'update_todo_list_cubit.dart';

@immutable
abstract class UpdateTodoListState {}

class UpdateTodoListInitial extends UpdateTodoListState {}

class UpdateTodoListSuccess extends UpdateTodoListState {}

class UpdateTodoListError extends UpdateTodoListState {}