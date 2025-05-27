import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process_git/domain/repo/todo_repo.dart';
import 'package:process_git/presentation/cubit/todo_cubit.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;
  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(create: (context) => TodoCubit(todoRepo),
    child: Text("hey, whatsapp"),);
  }
}