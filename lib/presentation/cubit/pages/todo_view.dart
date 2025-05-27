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
              IconButton(
                onPressed: () {
                  cubit.addTodo(textcontroller.text);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myCubit = context.read<TodoCubit>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddDialog(context),
        child: Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.green,
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todosi) {
          return ListView.builder(
            itemCount: todosi.length,
            itemBuilder: (context, index) {
              final todo = todosi[index];

              return ListTile(
                title: Text(todo.text, style: TextStyle(color: Colors.grey)),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => myCubit.toggleCompletion(todo),
                ),
                trailing: IconButton(
                  onPressed: () => myCubit.deleteTodo(todo),
                  icon: Icon(Icons.cancel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
