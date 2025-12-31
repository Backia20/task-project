import 'dart:async';

class MockApiService {
  // Singleton
  static final MockApiService _instance = MockApiService._internal();
  factory MockApiService() => _instance;
  MockApiService._internal();

  // Users
  final Map<String, Map<String, dynamic>> _users = {
    "test@test.com": {
      "password": "123456",
      "id": "1",
      "name": "Backia Lakshmi",
      "phone": "9876543210",
    }
  };

  // Lockers
  final List<Map<String, dynamic>> _lockers = [
    {"lockerId": "L001", "size": "Medium", "status": "Available"},
    {"lockerId": "L002", "size": "Large", "status": "In Use"},
    {"lockerId": "L003", "size": "Small", "status": "Available"},
  ];

  final Map<String, List<Map<String, dynamic>>> _lockerLogs = {};

  // Register
  Future<Map<String, dynamic>> register(
      String name, String email, String phone, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.containsKey(email)) {
      throw Exception("User already exists");
    }
    _users[email] = {
      "password": password,
      "id": (_users.length + 1).toString(),
      "name": name,
      "phone": phone,
    };
    return {
      "token": "fake_jwt_token_${_users.length}",
      "user": {
        "id": _users[email]!["id"],
        "name": name,
        "email": email,
        "phone": phone
      }
    };
  }

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.containsKey(email) && _users[email]!["password"] == password) {
      return {
        "token": "fake_jwt_token_login",
        "user": {
          "id": _users[email]!["id"],
          "name": _users[email]!["name"],
          "email": email,
          "phone": _users[email]!["phone"]
        }
      };
    } else {
      throw Exception("Invalid email or password");
    }
  }

  // Get lockers
  Future<List<Map<String, dynamic>>> getLockers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _lockers;
  }

  // Get locker logs
  Future<List<Map<String, dynamic>>> getLockerLogs(String lockerId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _lockerLogs[lockerId] ?? [];
  }

  // Open locker
  Future<void> openLocker(String lockerId) async {
    await Future.delayed(const Duration(seconds: 1));
    final now = DateTime.now();
    final log = {
      "date":
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}",
      "time":
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}",
      "action": "Opened",
      "lockerId": lockerId
    };
    _lockerLogs[lockerId] = [...?_lockerLogs[lockerId], log];
  }
}
