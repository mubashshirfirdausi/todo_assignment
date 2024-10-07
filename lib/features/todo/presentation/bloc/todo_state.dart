part of 'todo_bloc.dart';

@immutable
class TodoState {
  final List<Todo> todos;
  final bool isLoading;

  const TodoState({required this.todos, required this.isLoading});
}

class TodoInitial extends TodoState {
  const TodoInitial({required super.todos, required super.isLoading});
}

// class TodoLoading extends TodoState {
//   const TodoLoading(super.todos);
// }

// class TodoLoaded extends TodoState {
//   const TodoLoaded(super.todos);
// }

// class TodoAdded extends TodoState {
//   const TodoAdded(super.todos);
// }

// class TodoUpdated extends TodoState {
//   const TodoUpdated(super.todos);
// }
