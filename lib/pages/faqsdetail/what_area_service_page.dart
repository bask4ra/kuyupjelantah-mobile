import 'package:flutter/material.dart';

class WhatAreaServicePage extends StatelessWidget {
  const WhatAreaServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle bodyStyle = const TextStyle(fontSize: 14, height: 1.6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'What area are the service available?',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            Text('Area Layanan yang Tersedia', style: titleStyle),
            const SizedBox(height: 10),
            Text(
              'Saat ini, layanan penjemputan minyak jelantah hanya tersedia di wilayah Jabodetabek, yang mencakup:',
              style: bodyStyle,
            ),
            const SizedBox(height: 12),
            Text('a. Jakarta Pusat', style: bodyStyle),
            Text('b. Jakarta Utara', style: bodyStyle),
            Text('c. Jakarta Selatan', style: bodyStyle),
            Text('c. Jakarta Timur', style: bodyStyle),
            Text('d. Jakarta Barat', style: bodyStyle),
            Text('e. Depok', style: bodyStyle),
            Text('f. Tangerang & Tangerang Selatan', style: bodyStyle),
            Text('g. Bekasi (Kota & Kabupaten)', style: bodyStyle),
            Text('h. Bogor (Kota)', style: bodyStyle),
            const SizedBox(height: 20),
            Text(
              'Kami terus berupaya memperluas layanan ke kota-kota lainnya. '
                  'Pastikan Anda memasukkan alamat yang sesuai dengan wilayah layanan saat melakukan penjadwalan.',
              style: bodyStyle,
            ),
          ],
        ),
      ),
    );
  }
}
