import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/screen/home/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: provider.textEditingController,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<HomeProvider>().save();
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    provider.todoEntity?.id != null ? "Editar" : "Agregar",
                  ),
                )
              ],
            ),
            if (provider.todoList.isEmpty)
              const Text("No existe detalles del To Do"),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final todoEntity =
                      context.read<HomeProvider>().todoList[index];
                  return ListTile(
                    title: Text(
                      todoEntity.title,
                      style: TextStyle(
                        decoration: todoEntity.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await context.read<HomeProvider>().deleteOneTodo(
                                  idTodo: todoEntity.id!,
                                );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<HomeProvider>().changeEntity(
                                    todoEntity: todoEntity,
                                  );
                            },
                            icon: Icon(
                              Icons.update,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    leading: Checkbox(
                      value: todoEntity.isDone,
                      onChanged: (value) {
                        context.read<HomeProvider>().updateOneTodo(
                              todoEntity: todoEntity.copyWith(isDone: value),
                            );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black.withOpacity(0.5),
                ),
                itemCount: provider.todoList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
