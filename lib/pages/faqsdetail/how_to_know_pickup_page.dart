import 'package:flutter/material.dart';

class HowToKnowPickupPage extends StatelessWidget {
  const HowToKnowPickupPage({super.key});

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
          'How do I know when the pick up are coming?',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            Text('Kapan Penjemputan Akan Datang?', style: titleStyle),
            const SizedBox(height: 10),
            Text(
              'Setelah Anda menjadwalkan penjemputan melalui aplikasi, tim Kuyup Jelantah akan memproses permintaan Anda.',
              style: bodyStyle,
            ),
            const SizedBox(height: 12),
            Text('Konfirmasi Penjemputan', style: titleStyle),
            const SizedBox(height: 8),
            Text(
              'Sebelum kurir datang, Anda akan menerima notifikasi atau pesan langsung melalui WhatsApp dari tim kami.',
              style: bodyStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Pesan ini akan berisi:\n'
                  'a. Hari dan jam estimasi penjemputan\n'
                  'b. Nama kurir (jika tersedia)\n'
                  'c. Konfirmasi alamat dan jumlah liter',
              style: bodyStyle,
            ),
            const SizedBox(height: 16),
            Text(
              'Pastikan nomor telepon yang Anda masukkan aktif dan bisa dihubungi melalui WhatsApp.',
              style: bodyStyle,
            ),
          ],
        ),
      ),
    );
  }
}
