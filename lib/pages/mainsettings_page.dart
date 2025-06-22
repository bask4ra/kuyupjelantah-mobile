import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuyupjelantah/pages/mainsettings/contact_support_page.dart';
import 'package:kuyupjelantah/pages/mainsettings/notification_page.dart';
import 'package:kuyupjelantah/pages/settings_page.dart';
import 'package:kuyupjelantah/pages/welcome_page.dart';

class MainSettingsPage extends StatelessWidget {
  const MainSettingsPage({super.key});

  Future<void> _launchPlayStore() async {
    final Uri playStoreUri = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.kuyup.jelantah',
    );
    if (!await launchUrl(playStoreUri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $playStoreUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<_SettingsItem> items = [
      _SettingsItem(Icons.person, 'Account', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
      }),
      _SettingsItem(Icons.notifications, 'Notification', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage()));
      }),
      _SettingsItem(Icons.star, 'Rate App', _launchPlayStore),
      _SettingsItem(Icons.share, 'Share App', () {
      }),
      _SettingsItem(Icons.email, 'Contact Support', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactSupportPage()));
      }),
      _SettingsItem(Icons.logout, 'Sign Out', () async {
        await FirebaseAuth.instance.signOut();
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const WelcomePage()),
                (route) => false,
          );
        }
      }),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('General', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 16),
            ...items.map((item) => _buildSettingsItem(context, item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, _SettingsItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFFFD699),
                  child: Icon(item.icon, color: Colors.orange),
                ),
                const SizedBox(width: 16),
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _SettingsItem(this.icon, this.title, this.onTap);
}
