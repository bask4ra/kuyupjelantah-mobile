import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How do I schedule a pick up?',
    },
    {
      'question': 'What area are the service available?',
    },
    {
      'question': 'How do I know when\nthe pick up are coming?',
    },
    {
      'question': 'What payment method\ncan be done through?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // tetap tidak ada bayangan
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
        // Garis bawah dihapus
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
            ...faqs.map((faq) => _buildFAQCard(faq['question']!)),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCard(String question) {
    return Container(
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
    );
  }
}
