import 'package:flutter/material.dart';

class Pert1Page extends StatefulWidget {
  const Pert1Page({super.key});

  @override
  State<Pert1Page> createState() => _Pert1PageState();
}

class _Pert1PageState extends State<Pert1Page> {
  int _counter = 0;

  void _tambah() {
    setState(() {
      _counter++;
    });
  }

  void _kurang() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PROFIL
            const Icon(
              Icons.flutter_dash,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Nama: Andrew',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              'NIM: 20240801024',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Jurusan: Teknik Informatika',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Hobi: Tidur',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            // COUNTER
            const Text(
              'Counter',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),

            Text(
              '$_counter',
              style: const TextStyle(fontSize: 40),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _kurang,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _tambah,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}