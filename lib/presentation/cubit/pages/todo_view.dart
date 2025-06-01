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
    final textcontroller = TextEditingController();
    final cubit = context.read<TodoCubit>();


    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(
              controller: textcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),

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

  void editTodoDialog(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textController),

            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                   cubit.updatedTodo(textController.text as Todo);
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
                  onPressed: () => editTodoDialog(context),
                  icon: Icon(Icons.edit)
                ),

              );
            },
          );
        },
      ),
    );
  }
}
