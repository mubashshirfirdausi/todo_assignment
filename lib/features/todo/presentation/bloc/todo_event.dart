part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;

  AddTodo(this.title);
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo(this.id);
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo({required this.todo});
}
