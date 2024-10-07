import '../data_source/todo_local_data_source.dart';
import '../models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> saveTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<List<Todo>> fetchTodos() async {
    return await localDataSource.fetchTodos();
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await localDataSource.saveTodo(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await localDataSource.updateTodo(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localDataSource.deleteTodo(id);
  }
}
