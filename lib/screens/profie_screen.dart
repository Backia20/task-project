import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("User Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            if (user != null) ...[
              Text("Name: ${user['name']}", style: const TextStyle(fontSize: 18)),
              Text("Email: ${user['email']}", style: const TextStyle(fontSize: 18)),
              Text("Phone: ${user['phone']}", style: const TextStyle(fontSize: 18)),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                auth.logout(); // logout does not need await
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
