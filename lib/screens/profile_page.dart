import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userEmail;
  final int savedTripsCount;

  const ProfilePage({
    super.key,
    required this.userEmail,
    required this.savedTripsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.teal),
            const SizedBox(height: 20),
            Text("Email: $userEmail", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              "Trips Saved: $savedTripsCount",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Optionally call signOut()
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logout not implemented")),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
