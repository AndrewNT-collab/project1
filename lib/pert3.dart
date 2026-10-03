import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pert3Page extends StatefulWidget {
  const Pert3Page({super.key});

  @override
  State<Pert3Page> createState() => _Pert3PageState();
}

class _Pert3PageState extends State<Pert3Page> {
  final _formKey = GlobalKey<FormState>();

  String _nama = '';
  String _email = '';
  String _jurusan = 'Teknik Informatika';
  bool _setuju = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data berhasil disimpan untuk $_nama',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pendaftaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nama = value!;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }

                  if (!value.contains('@')) {
                    return 'Email harus mengandung @';
                  }

                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _jurusan,
                decoration: const InputDecoration(
                  labelText: 'Jurusan',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Teknik Informatika',
                    child: Text('Teknik Informatika'),
                  ),
                  DropdownMenuItem(
                    value: 'Sistem Informasi',
                    child: Text('Sistem Informasi'),
                  ),
                  DropdownMenuItem(
                    value: 'Teknik Elektro',
                    child: Text('Teknik Elektro'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _jurusan = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              CheckboxListTile(
                title: const Text(
                  'Saya menyetujui data yang diberikan',
                ),
                value: _setuju,
                onChanged: (value) {
                  setState(() {
                    _setuju = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _setuju ? _submit : null,
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tugas {
  final String judul;
  bool selesai;

  Tugas(
      this.judul, {
        this.selesai = false,
      });
}

class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];

  List<Tugas> get items => List.unmodifiable(_items);

  int get jumlahSelesai {
    return _items.where((item) => item.selesai).length;
  }

  void tambah(String judul) {
    _items.add(Tugas(judul));
    notifyListeners();
  }

  void toggle(int index) {
    _items[index].selesai = !_items[index].selesai;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tugas (${model.jumlahSelesai} selesai)',
        ),
      ),
      body: model.items.isEmpty
          ? const Center(
        child: Text('Belum ada tugas'),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, index) {
          final tugas = model.items[index];

          return ListTile(
            leading: Checkbox(
              value: tugas.selesai,
              onChanged: (_) {
                context.read<TugasModel>().toggle(index);
              },
            ),
            title: Text(
              tugas.judul,
              style: TextStyle(
                decoration: tugas.selesai
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<TugasModel>().hapus(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
class TambahPage extends StatefulWidget {
  const TambahPage({super.key});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final TextEditingController _controller =
  TextEditingController();

  void _simpan() {
    final judul = _controller.text.trim();

    if (judul.isEmpty) {
      return;
    }

    context.read<TugasModel>().tambah(judul);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Judul tugas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _simpan,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}