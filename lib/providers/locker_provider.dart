import 'package:flutter/material.dart';
import '../services/mock_api_service.dart';

class LockerProvider extends ChangeNotifier {
  final MockApiService api = MockApiService();
  bool isLoading = false;
  List<Map<String, dynamic>> lockers = [];
  Map<String, List<Map<String, dynamic>>> logs = {};

  Future<void> fetchLockers() async {
    isLoading = true;
    notifyListeners();
    try {
      lockers = await api.getLockers();
      for (var locker in lockers) {
        final lockerId = locker['lockerId'] as String;
        final lockerLogs = await api.getLockerLogs(lockerId);
        logs[lockerId] = lockerLogs;
        locker['lastAccessed'] =
            (lockerLogs.isNotEmpty) ? lockerLogs.last['date'] : "Never";
      }
    } catch (e) {
      print("Error fetching lockers: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> openLocker(String lockerId) async {
    isLoading = true;
    notifyListeners();
    try {
      await api.openLocker(lockerId);
      final lockerLogs = await api.getLockerLogs(lockerId);
      logs[lockerId] = lockerLogs;
      final locker = lockers.firstWhere((l) => l['lockerId'] == lockerId);
      locker['lastAccessed'] =
          (lockerLogs.isNotEmpty) ? lockerLogs.last['date'] : "Never";
    } catch (e) {
      print("Error opening locker: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
