import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process_git/domain/models/todo.dart';
import 'package:process_git/presentation/cubit/todo_cubit.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  void showAddDialog(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    final textcontroller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textcontroller),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  cubit.addTodo(textcontroller.text);
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddDialog(context),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey,
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return ListTile(
                title: Text(todo.text),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => cubit.toggleCompletion(todo),
                ),
                trailing: IconButton(
                  onPressed: () => cubit.deleteTodo(todo),
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
