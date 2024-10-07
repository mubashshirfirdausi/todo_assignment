// lib/models/todo.dart
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  bool isDone;

  Todo({
    String? id,
    required this.title,
    this.isDone = false,
  }) : id = id ?? Uuid().v4();
}
