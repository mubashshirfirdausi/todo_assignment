import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../bloc/todo_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(FetchTodos());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAddTodoField(),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final List<Todo> uncheckedTodos = state.todos.where((todo) => !todo.isDone).toList();
                    final List<Todo> checkedTodos = state.todos.where((todo) => todo.isDone).toList();

                    return Column(
                      children: [
                        _buildTodoList('Pending Todos', uncheckedTodos, context),
                        const SizedBox(height: 16),
                        Divider(color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        _buildTodoList('Completed Todos', checkedTodos, context),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTodoField() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Add a new task',
        labelStyle: TextStyle(color: Colors.deepPurple.shade400),
        fillColor: Colors.deepPurple.shade50,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.add, color: Colors.deepPurple),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              BlocProvider.of<TodoBloc>(context).add(AddTodo(_controller.text));
              _controller.clear();
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple.shade700),
        ),
      ),
    );
  }

  Widget _buildTodoList(String title, List<Todo> todos, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return _buildTodoCard(todo, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoCard(Todo todo, BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      onDismissed: (direction) {
        BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo.id));
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            value: todo.isDone,
            onChanged: (value) {
              final updatedTodo = Todo(
                id: todo.id,
                title: todo.title,
                isDone: value!,
              );
              BlocProvider.of<TodoBloc>(context).add(UpdateTodo(todo: updatedTodo));
            },
            activeColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
