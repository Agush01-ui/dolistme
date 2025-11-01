import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/todo_controller.dart';

void main() {
  runApp(const DoListMeApp());
}

class DoListMeApp extends StatelessWidget {
  const DoListMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Do List Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF1FAEE),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF2D6A4F), // hijau tua
          secondary: const Color(0xFF95D5B2), // hijau muda
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF40916C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome>
    with SingleTickerProviderStateMixin {
  final TodoController controller = Get.put(TodoController());
  final TextEditingController textController = TextEditingController();
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Do List Me ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D6A4F),
        elevation: 3,
        shadowColor: Colors.black26,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInputArea(),
            const SizedBox(height: 16),
            Expanded(child: _buildTodoList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF52B788),
        icon: const Icon(Icons.add),
        label: const Text("Tambah Tugas"),
        onPressed: () {
          controller.addTodo(textController.text);
          textController.clear();
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: "Tulis kegiatan kamu hari ini",
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                controller.addTodo(value);
                textController.clear();
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add_circle_rounded,
              color: Color(0xFF40916C),
            ),
            iconSize: 30,
            onPressed: () {
              controller.addTodo(textController.text);
              textController.clear();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return Obx(() {
      if (controller.todos.isEmpty) {
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
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          final todo = controller.todos[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: todo.isDone ? const Color(0xFFD8F3DC) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: Checkbox(
                value: todo.isDone,
                activeColor: const Color(0xFF2D6A4F),
                onChanged: (_) => controller.toggleTodoStatus(index),
              ),
              title: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 16,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: todo.isDone
                      ? Colors.green[300]
                      : const Color(0xFF1B4332),
                  fontWeight: todo.isDone ? FontWeight.normal : FontWeight.w500,
                ),
                child: Text(todo.title),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFF74C69D),
                ),
                onPressed: () => controller.removeTodoAt(index),
              ),
            ),
          );
        },
      );
    });
  }
}
