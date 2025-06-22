import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  void _openWhatsApp() async {
    final Uri url = Uri.parse('https://wa.me/6281234567890');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch WhatsApp';
    }
  }

  void _openFacebook() async {
    final Uri url = Uri.parse('https://facebook.com/kuyupjelantah');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch Facebook';
    }
  }

  void _openEmail() async {
    final Uri email = Uri(
      scheme: 'mailto',
      path: 'info@kuyupjelantah-mobile.firebaseapp.com',
    );
    if (!await launchUrl(email)) {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Support',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need help? Contact us through:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildContactTile(
              icon: Icons.chat,
              title: 'WhatsApp',
              subtitle: '+62 812-3456-7890',
              onTap: _openWhatsApp,
            ),
            const SizedBox(height: 12),
            _buildContactTile(
              icon: Icons.facebook_rounded,
              title: 'Facebook',
              subtitle: 'facebook.com/kuyupjelantah',
              onTap: _openFacebook,
            ),
            const SizedBox(height: 12),
            _buildContactTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'info@kuyupjelantah-mobile.firebaseapp.com',
              onTap: _openEmail,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
