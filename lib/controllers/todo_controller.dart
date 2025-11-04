import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  // observable list
  final todos = <Todo>[].obs;

  // Text controller for input field (kehilangan ini sering penyebab error)
  final TextEditingController todoController = TextEditingController();

  // add task (mengambil dari todoController.text bila kosong dipanggil dari UI)
  void addTodo([String? text]) {
    final value = (text ?? todoController.text).trim();
    if (value.isEmpty) {
      Get.snackbar(
        "Peringatan ⚠️",
        "Tugas tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    todos.add(Todo(title: value));
    todoController.clear();
  }

  void toggleTodoStatus(int index) {
    final t = todos[index];
    todos[index] = Todo(title: t.title, isDone: !t.isDone);
  }

  void removeTodo(int index) {
    if (index >= 0 && index < todos.length) {
      todos.removeAt(index);
    }
  }

  @override
  void onClose() {
    todoController.dispose();
    super.onClose();
  }
}
