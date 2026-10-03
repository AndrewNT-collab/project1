import 'package:flutter/material.dart';

class Kontak {
  final String nama;
  final String telepon;
  final String email;

  const Kontak(
      this.nama,
      this.telepon,
      this.email,
      );
}
const daftarKontak = [
  Kontak(
    'Andi',
    '081234567890',
    'andi@gmail.com',
  ),
  Kontak(
    'Budi',
    '081234567891',
    'budi@gmail.com',
  ),
  Kontak(
    'Citra',
    '081234567892',
    'citra@gmail.com',
  ),
  Kontak(
    'Dinda',
    '081234567893',
    'dinda@gmail.com',
  ),
  Kontak(
    'Eko',
    '081234567894',
    'eko@gmail.com',
  ),
  Kontak(
    'Fajar',
    '081234567895',
    'fajar@gmail.com',
  ),
];
class Pert2Page extends StatelessWidget {
  const Pert2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(
                kontak.nama[0].toUpperCase(),
              ),
            ),
            title: Text(kontak.nama),
            subtitle: Text(kontak.telepon),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailKontakPage(
                    kontak: kontak,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailKontakPage extends StatelessWidget {
  final Kontak kontak;

  const DetailKontakPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kontak'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              child: Text(
                kontak.nama[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              kontak.nama,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Telepon: ${kontak.telepon}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${kontak.email}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}