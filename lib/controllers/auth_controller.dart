import 'package:flutter/material.dart'; // ✅ tambahkan ini
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();

  // login: simpan username dan pindah ke HomeScreen
  Future<void> login() async {
    final username = nameController.text.trim();
    if (username.isEmpty) {
      Get.snackbar(
        "Peringatan ⚠️",
        "Nama tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    Get.off(() => const HomeScreen());
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    // kembali ke login
    Get.offAll(() => const LoginScreen());
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') != null;
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
