import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuyupjelantah/pages/welcome_page.dart';
import '../pages/login_page.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          // Logo
          Row(
            children: [
              Image.asset(
                'assets/images/secondlogo.png',
                height: 64,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // User info (real-time)
          if (user != null)
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                final userData = snapshot.data?.data() as Map<String, dynamic>?;

                final displayName = userData?['name'] ?? 'Guest';
                final email = user.email ?? '';

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (email.isNotEmpty)
                        Text(
                          email,
                          style: const TextStyle(color: Colors.black54),
                        ),
                    ],
                  ),
                );
              },
            ),

          const SizedBox(height: 32),

          // Menu
          drawerItem(context, Icons.dashboard, 'Dashboard', onTap: () {
            Navigator.pop(context);
          }),
          drawerItem(context, Icons.schedule, 'Schedule', onTap: () {
            Navigator.pushNamed(context, '/schedule');
          }),

          drawerItem(context, Icons.stars, 'Royalty Reward'),
          drawerItem(context, Icons.history, 'History', onTap: () {
            Navigator.pushNamed(context, '/history');
          }),

          const SizedBox(height: 16),
          const Divider(color: Colors.black12),
          const SizedBox(height: 16),

          drawerItem(context, Icons.settings, 'Settings', onTap: () {
            Navigator.pushNamed(context, '/main-settings');
          }),

          drawerItem(context, Icons.help_outline, 'FAQs', onTap: () {
            Navigator.pushNamed(context, '/faqscreen');
          }),
          drawerItem(context, Icons.logout, 'Sign Out', onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WelcomePage()),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget drawerItem(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap ?? () {
        Navigator.pop(context);
      },
    );
  }
}
