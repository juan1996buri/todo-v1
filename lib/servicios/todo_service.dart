import 'package:to_do/entities/todo_entity.dart';

List<TodoEntity> todoList = [
  TodoEntity(isDone: false, title: "Limpiar el cuarto", id: 1),
  TodoEntity(isDone: true, title: "hacer la comida", id: 2),
  TodoEntity(isDone: true, title: "Lavar los platos", id: 3),
];

class TodoServices {
  Future<List<TodoEntity>> findAll() async {
    Future.delayed(const Duration(seconds: 4));
    return todoList;
  }

  Future<bool> deleteOne({required int idTodo}) async {
    return true;
  }

  Future<bool> updateOne({required TodoEntity todoEntity}) async {
    return true;
  }

  Future<bool> createOne({required TodoEntity todoEntity}) async {
    return true;
  }
}
