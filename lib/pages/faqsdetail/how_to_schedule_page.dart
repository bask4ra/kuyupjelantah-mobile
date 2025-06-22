import 'package:flutter/material.dart';

class HowToSchedulePage extends StatelessWidget {
  const HowToSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle bodyStyle = const TextStyle(fontSize: 14, height: 1.5);

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
          'How do I Schedule a Pick Up?',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            Text('Langkah-langkah Penjadwalan Pick Up', style: titleStyle),
            const SizedBox(height: 10),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'I. Buka Menu “Schedule”', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
              'Temukan menu Schedule di bagian bawah aplikasi. Tekan untuk masuk ke halaman penjadwalan.',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'II. Isi Jumlah Liter Minyak Jelantah', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
              'Masukkan perkiraan jumlah liter minyak jelantah yang ingin Anda setorkan. Minimal jumlah biasanya 1 liter (tergantung kebijakan platform).',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'III. Lengkapi Informasi Alamat Penjemputan', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
              'Isi data berikut dengan lengkap:\n  a. Alamat lengkap\n  b. Kota / Kabupaten\n  c. Provinsi\n  d. Kode Pos\n  e. Nomor Telepon Aktif\nPastikan data akurat agar kurir tidak kesulitan menemukan lokasi Anda.',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'IV. Pilih Tanggal Penjemputan (Opsional)', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
              'Jika tersedia, Anda bisa memilih tanggal tertentu untuk penjemputan. Jika tidak, tim kami akan mengatur jadwal berdasarkan antrean dan ketersediaan kurir.',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'V. Klik Tombol “Schedule”', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
              'Setelah semua data terisi, klik tombol Schedule untuk menyimpan dan mengirim permintaan. Anda akan menerima konfirmasi bahwa jadwal berhasil dibuat.',
              style: bodyStyle,
            ),
            const SizedBox(height: 20),

            Text('Apa yang Terjadi Setelah Penjadwalan?', style: titleStyle),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                style: bodyStyle,
                children: [
                  TextSpan(text: 'I. ', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'Tim penjemput akan memproses permintaan Anda.\n'),
                  TextSpan(text: 'II. ', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'Anda bisa melihat status atau riwayat penjemputan di menu History.\n'),
                  TextSpan(text: 'III. ', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'Saat kurir tiba, cukup serahkan minyak jelantah sesuai jumlah yang dijanjikan.'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Apa yang Saya Dapatkan Setelah Penjemputan?', style: titleStyle),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                style: bodyStyle,
                children: [
                  TextSpan(text: 'I. ', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'Anda akan mendapatkan bukti transaksi (Receipt) yang bisa dilihat di menu History.\n'),
                  TextSpan(text: 'II. ', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'Jumlah liter yang disetorkan akan dikonversi menjadi saldo atau poin (jika berlaku).\n'),
                  TextSpan(text: 'III. ', style: bodyStyle.copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'Detail transaksi seperti tanggal, alamat, dan jumlah liter akan disimpan.'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Tips & Pertanyaan Umum', style: titleStyle),
            const SizedBox(height: 8),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'I. Apakah saya bisa menjadwalkan ulang?\n',
                    style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Ya, Anda bisa membatalkan jadwal dan membuat yang baru sebelum penjemputan dilakukan.',
                    style: bodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'II. Berapa minimal jumlah yang bisa dijemput?\n',
                    style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Minimal biasanya 1–2 liter, tergantung wilayah operasional. Cek syarat di halaman utama.',
                    style: bodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'III. Apakah saya akan dikenakan biaya penjemputan?\n',
                    style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Umumnya tidak, tapi akan tertera jika ada potongan biaya administrasi (contoh: Rp 2.500).',
                    style: bodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
