import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/locker_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final lockerProvider =
        Provider.of<LockerProvider>(context, listen: false);
    lockerProvider.fetchLockers();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final lockerProvider = Provider.of<LockerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                auth.logout();
                Navigator.pushReplacementNamed(context, '/login');
              })
        ],
      ),
      body: lockerProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: lockerProvider.lockers.length,
              itemBuilder: (context, index) {
                final locker = lockerProvider.lockers[index];
                final lockerId = locker['lockerId'];
                final lastAccess = locker['lastAccessed'] ?? 'Never';
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text("Locker: $lockerId (${locker['size']})"),
                    subtitle: Text("Last Accessed: $lastAccess"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        lockerProvider.openLocker(lockerId);
                      },
                      child: const Text("Open"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
