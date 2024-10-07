// lib/data_sources/todo_local_data_source.dart
import 'package:hive/hive.dart';
import '../models/todo.dart';

class TodoLocalDataSource {
  final Box<Todo> todoBox;

  TodoLocalDataSource(this.todoBox);

  Future<List<Todo>> fetchTodos() async {
    return todoBox.values.toList();
  }

  Future<void> saveTodo(Todo todo) async {
    await todoBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await todoBox.delete(id);
  }

  Future<void> updateTodo(Todo todo) async {
    await todoBox.delete(todo.id);
    await todoBox.put(todo.id, todo);
  }
}
