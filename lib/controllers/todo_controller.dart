import 'package:get/get.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todos = <TodoModel>[].obs;

  void addTodo(String title) {
    if (title.isNotEmpty) {
      todos.add(TodoModel(title: title));
    }
  }

  void toggleTodoStatus(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
  }
}
