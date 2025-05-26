import 'package:isar/isar.dart';
import 'package:process_git/domain/models/todo.dart';


part 'isar_todo.g.dart';
@collection
class IsarTodo {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;



Todo toDomain() {
  return Todo(id: id, text: text, isCompleted: isCompleted);
}

 static IsarTodo fromDomain(Todo todo) {
  return IsarTodo()
  ..id = todo.id
  ..text = todo.text
  ..isCompleted = todo.isCompleted;
 }

}