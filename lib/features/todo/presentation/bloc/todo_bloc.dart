import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repository/todo_repository.dart';

import '../../data/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc({required this.todoRepository}) : super(TodoInitial(isLoading: false, todos: [])) {
    on<FetchTodos>((event, emit) async {
      emit(TodoState(isLoading: true, todos: []));
      final todos = await todoRepository.fetchTodos();
      state.todos.clear();
      emit(TodoState(isLoading: false, todos: todos));
    });

    on<AddTodo>((event, emit) async {
      final todo = Todo(title: event.title);
      await todoRepository.saveTodo(todo);
      state.todos.add(todo);
      emit(TodoState(isLoading: false, todos: [...state.todos]));
    });

    on<UpdateTodo>((event, emit) async {
      await todoRepository.updateTodo(event.todo);
      state.todos.firstWhere((todo) => todo.id == event.todo.id).isDone = event.todo.isDone;
      (event.todo.id);
      emit(TodoState(isLoading: false, todos: [...state.todos]));
    });

    on<DeleteTodo>((event, emit) async {
      await todoRepository.deleteTodo(event.id);
      state.todos.removeWhere((todo) => todo.id == event.id);
      emit(TodoState(isLoading: false, todos: [...state.todos]));
    });
  }
}
