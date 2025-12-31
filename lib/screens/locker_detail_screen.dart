import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locker_provider.dart';
import 'logs_screen.dart';

class LockerDetailScreen extends StatelessWidget {
  final Map<String, dynamic> locker;
  const LockerDetailScreen({super.key, required this.locker});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LockerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Locker ${locker["lockerId"]}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Size: ${locker["size"]}"),
            Text("Status: ${locker["status"]}"),
            Text("Last Accessed: ${locker["lastAccessed"]}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await provider.openLocker(locker["lockerId"]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Locker opened successfully")),
                );
              },
              child: const Text("Open Locker"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LogsScreen()));
              },
              child: const Text("View Logs"),
            )
          ],
        ),
      ),
    );
  }
}
