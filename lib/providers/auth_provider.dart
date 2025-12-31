import 'package:flutter/material.dart';
import '../services/mock_api_service.dart';

class AuthProvider with ChangeNotifier {
  final MockApiService api = MockApiService();
  bool isLoading = false;
  Map<String, dynamic>? user;

  Future<void> register(
      String name, String email, String phone, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await api.register(name, email, phone, password);
      user = res["user"];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await api.login(email, password);
      user = res["user"];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
