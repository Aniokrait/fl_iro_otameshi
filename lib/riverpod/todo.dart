import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_list.dart';
import 'package:uuid/uuid.dart';

@immutable
class Todo {
  const Todo(
      {required this.id, required this.description, required this.completed});

  final String id;
  final String description;
  final bool completed;

  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(inputText) {
    state = [
      ...state,
      Todo(id: const Uuid().v4(), description: inputText, completed: false),
    ];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
        // イミュータブルだから↓のようなことはできない
        // todo.completed = !todo.completed
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

