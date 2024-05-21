import 'dart:convert';

import 'package:to_do/entities/todo_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _todo = "todo";

class TodoLocal {
  Future<List<TodoEntity>?> findAll() async {
    final sp = await SharedPreferences.getInstance();
    final response = sp.get(_todo);
    if (response == null) {
      return [];
    } else {
      return todoEntityFromJson(response.toString());
    }
  }

  Future<void> deleteTodo({required List<TodoEntity> todoList}) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_todo, todoEntityToJson(todoList));
  }

  Future<void> updateTodo({required List<TodoEntity> todoList}) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_todo, todoEntityToJson(todoList));
  }

  Future<void> createAll({required List<TodoEntity> todoList}) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_todo, todoEntityToJson(todoList));
  }
}
