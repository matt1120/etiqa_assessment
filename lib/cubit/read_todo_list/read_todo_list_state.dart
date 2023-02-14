// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'read_todo_list_cubit.dart';

@immutable
abstract class ReadTodoListState {}

class ReadTodoListInitial extends ReadTodoListState {}

class ReadTodoListSuccess extends ReadTodoListState {
  final List todoList;
  ReadTodoListSuccess({
    required this.todoList,
  });
}

class ReadTodoListFailure extends ReadTodoListState {}
