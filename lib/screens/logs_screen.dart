import 'package:flutter/material.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {
        "date": "2025-01-01",
        "time": "10:30 AM",
        "action": "Opened",
        "locker": "L001"
      },
      {
        "date": "2025-01-02",
        "time": "11:00 AM",
        "action": "Closed",
        "locker": "L002"
      }
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Locker Logs")),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return ListTile(
            title: Text("Locker ${log["locker"]} - ${log["action"]}"),
            subtitle: Text("${log["date"]} | ${log["time"]}"),
          );
        },
      ),
    );
  }
}
