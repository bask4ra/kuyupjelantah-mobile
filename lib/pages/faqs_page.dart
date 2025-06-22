import 'package:flutter/material.dart';
import 'package:kuyupjelantah/pages/faqsdetail/how_to_schedule_page.dart';
import 'package:kuyupjelantah/pages/faqsdetail/what_area_service_page.dart';
import 'package:kuyupjelantah/pages/faqsdetail/how_to_know_pickup_page.dart';
import 'package:kuyupjelantah/pages/mainsettings/contact_support_page.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  final List<Map<String, dynamic>> faqs = const [
    {
      'question': 'How do I schedule a pick up?',
      'page': HowToSchedulePage(),
    },
    {
      'question': 'What area are the service available?',
      'page': WhatAreaServicePage(),
    },
    {
      'question': 'How do I know when\nthe pick up are coming?',
      'page': HowToKnowPickupPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'FAQs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF2B202C),
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Color(0xFF2B202C)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAQ’s',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF2B202C),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'We Cover Most Asked Question Here',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ...faqs.map((faq) => _buildFAQCard(context, faq['question'], faq['page'])),
          ],
        ),
      ),

      // 🔶 Floating Contact Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactSupportPage()),
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.message_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildFAQCard(BuildContext context, String question, Widget? page) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coming soon...')),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2B202C),
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF2B202C)),
          ],
        ),
      ),
    );
  }
}
