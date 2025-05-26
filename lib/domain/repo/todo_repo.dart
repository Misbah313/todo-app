import 'package:process_git/domain/models/todo.dart';

abstract class TodoRepo {
  // get the list of todos
  Future<void> getTodos(Todo todo);

  // add todo
  Future<void> addTodo(Todo newTodo);

  // delete todo
  Future<void> deleteTodo(Todo todo);

  // edit todo
  Future<void> editTodo(Todo todo);
}