import 'package:isar/isar.dart';
import 'package:process_git/data/models/isar_todo.dart';
import 'package:process_git/domain/models/todo.dart';
import 'package:process_git/domain/repo/todo_repo.dart';

class IsarTodoRepo implements TodoRepo{
  final Isar db;

  IsarTodoRepo(this.db);

  // get the list of todos
  @override
  Future<List<Todo>> getTodos(Todo todo) async {
    // fectch from db
    final todos = await db.isarTodos.where().findAll();

    // return as a list of todo and give to domain layer
    return todos.map((isarTodos) => isarTodos.toDomain()).toList();
  }

  // add todo
  @override
  Future<void> addTodo(Todo newTodo) async{
    // convert todo obj into isar
   final todoIsar =  IsarTodo.fromDomain(newTodo);

    // so we can store in our db
   return db.writeTxn(() => db.isarTodos.put(todoIsar),);
    
  }

  // edit todo
  @override
  Future<void> editTodo(Todo todo) {
     // convert todo obj into isar
   final todoIsar =  IsarTodo.fromDomain(todo);

    // so we can store in our db
   return db.writeTxn(() => db.isarTodos.put(todoIsar),);
  }

  // delete
  @override
  Future<void> deleteTodo(Todo todo) async{
  await db.writeTxn(() => db.isarTodos.delete(todo.id),);
  }
  }

