import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My DoList 🌱",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF388E3C),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F8E9),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: todoController.todoController,
              decoration: InputDecoration(
                hintText: 'Add a new task...',
                prefixIcon: const Icon(
                  Icons.add_task,
                  color: Color(0xFF2E7D32),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => todoController.addTodo(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: todoController.addTodo,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43A047),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
            child: const Text(
              "Add Task",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (todoController.todos.isEmpty) {
                return const Center(
                  child: Text(
                    "Belum ada tugas",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF74C69D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: todoController.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoController.todos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        activeColor: const Color(0xFF2E7D32),
                        onChanged: (_) =>
                            todoController.toggleTodoStatus(index),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 18,
                          color: todo.isDone
                              ? Colors.grey
                              : const Color(0xFF1B5E20),
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => todoController.removeTodo(index),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
