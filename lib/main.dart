// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/todo/data/data_source/todo_local_data_source.dart';
import 'features/todo/data/models/todo.dart';
import 'features/todo/data/repository/todo_repository.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/screens/todo_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todoBox');

  final todoBox = Hive.box<Todo>('todoBox');
  final todoLocalDataSource = TodoLocalDataSource(todoBox);
  final todoRepository = TodoRepositoryImpl(todoLocalDataSource);

  runApp(MyApp(todoRepository: todoRepository));
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;

  const MyApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: false,
      ),
      title: 'Flutter Todo App',
      home: BlocProvider(
        create: (context) => TodoBloc(todoRepository: todoRepository),
        child: TodoScreen(),
      ),
    );
  }
}
