import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process_git/domain/models/todo.dart';
import 'package:process_git/domain/repo/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // l o a d 
  Future<void> loadTodos() async{
    final todoList = await todoRepo.getTodos();

    emit(todoList);
  }

  // a d d 
  Future<void> addTodo(String text) async{
    final newTodo = Todo(id: DateTime.now().microsecondsSinceEpoch, text: text);

    await todoRepo.addTodo(newTodo);

    loadTodos();
  }

  // d e l e t e
  Future<void> deleteTodo(Todo todo) async{
    await todoRepo.deleteTodo(todo);

    loadTodos();
  }
}