import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:to_do/entities/todo_entity.dart';
import 'package:to_do/servicios/todo_local.dart';
import 'package:to_do/servicios/todo_service.dart';

class HomeProvider extends ChangeNotifier {
  TodoServices todoServices = TodoServices();
  TodoLocal todoLocal = TodoLocal();
  TextEditingController textEditingController = TextEditingController();
  List<TodoEntity> todoList = [];
  TodoEntity? todoEntity;
  Future<void> findAllTodo() async {
    try {
      final response = await todoLocal.findAll();
      if (response!.isNotEmpty) {
        todoList = response;
      } else {
        todoList = await todoServices.findAll();
        await todoLocal.createAll(todoList: todoList);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteOneTodo({required int idTodo}) async {
    final response = await todoServices.deleteOne(idTodo: idTodo);
    if (response) {
      todoList.removeWhere((element) => element.id == idTodo);
      await todoLocal.deleteTodo(todoList: todoList);
      notifyListeners();
    }
  }

  Future<void> updateOneTodo({required TodoEntity todoEntity}) async {
    final response = await todoServices.updateOne(todoEntity: todoEntity);
    if (response) {
      final index =
          todoList.indexWhere((element) => element.id == todoEntity.id);
      todoList[index] = todoEntity;
      await todoLocal.updateTodo(todoList: todoList);
      notifyListeners();
    }
  }

  void changeEntity({required TodoEntity todoEntity}) {
    this.todoEntity = todoEntity;
    textEditingController.text = todoEntity.title;
    notifyListeners();
  }

  Future<void> createOneTodo() async {
    int randomNumber = Random().nextInt(90) + 1;
    final newTodo = TodoEntity(
      isDone: false,
      title: textEditingController.text,
      id: randomNumber,
    );
    final response = await todoServices.createOne(
      todoEntity: newTodo,
    );

    if (response) {
      todoList = [newTodo, ...todoList];
      await todoLocal.createAll(todoList: todoList);
    }
  }

  Future<void> save() async {
    if (todoEntity?.id != null) {
      await updateOneTodo(
        todoEntity: todoEntity!.copyWith(
          title: textEditingController.text,
        ),
      );
    } else {
      await createOneTodo();
    }

    todoEntity = null;
    textEditingController.text = "";
    notifyListeners();
  }
}
