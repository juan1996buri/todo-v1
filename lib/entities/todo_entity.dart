// To parse this JSON data, do
//
//     final todoEntity = todoEntityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TodoEntity> todoEntityFromJson(String str) =>
    List<TodoEntity>.from(json.decode(str).map((x) => TodoEntity.fromJson(x)));

String todoEntityToJson(List<TodoEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoEntity {
  final int? id;
  final bool isDone;
  final String title;

  TodoEntity({
    this.id,
    required this.isDone,
    required this.title,
  });

  TodoEntity copyWith({
    int? id,
    bool? isDone,
    String? title,
  }) =>
      TodoEntity(
        id: id ?? this.id,
        isDone: isDone ?? this.isDone,
        title: title ?? this.title,
      );

  factory TodoEntity.fromJson(Map<String, dynamic> json) => TodoEntity(
        id: json["id"],
        isDone: json["isDone"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isDone": isDone,
        "title": title,
      };
}
