import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Belanja {
  final String nama;
  final int jumlah;
  final String kategori;
  bool dibeli;

  Belanja(
      this.nama,
      this.jumlah,
      this.kategori, {
        this.dibeli = false,
      });
}

class BelanjaModel extends ChangeNotifier {
  final List<Belanja> _items = [];

  List<Belanja> get items => List.unmodifiable(_items);

  int get jumlahBelumDibeli =>
      _items.where((item) => !item.dibeli).length;

  void tambah(String nama, int jumlah, String kategori) {
    _items.add(
      Belanja(
        nama,
        jumlah,
        kategori,
      ),
    );
    notifyListeners();
  }

  void toggle(int index) {
    _items[index].dibeli = !_items[index].dibeli;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

class TugasMandiriPage extends StatelessWidget {
  const TugasMandiriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Belanja (${model.jumlahBelumDibeli} belum dibeli)',
        ),
      ),
      body: model.items.isEmpty
          ? const Center(
        child: Text('Belum ada barang'),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, index) {
          final item = model.items[index];

          return ListTile(
            leading: Checkbox(
              value: item.dibeli,
              onChanged: (_) {
                context
                    .read<BelanjaModel>()
                    .toggle(index);
              },
            ),
            title: Text(
              item.nama,
              style: TextStyle(
                decoration: item.dibeli
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(
              'Jumlah: ${item.jumlah} | Kategori: ${item.kategori}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context
                    .read<BelanjaModel>()
                    .hapus(index);
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
              builder: (_) => const TambahBelanjaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahBelanjaPage extends StatefulWidget {
  const TambahBelanjaPage({super.key});

  @override
  State<TambahBelanjaPage> createState() =>
      _TambahBelanjaPageState();
}

class _TambahBelanjaPageState
    extends State<TambahBelanjaPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController =
  TextEditingController();

  final TextEditingController _jumlahController =
  TextEditingController();

  String _kategori = 'Makanan';

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();
    final jumlah = int.parse(
      _jumlahController.text.trim(),
    );

    context.read<BelanjaModel>().tambah(
      nama,
      jumlah,
      _kategori,
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Belanja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama barang',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final jumlah =
                  int.tryParse(value ?? '');

                  if (jumlah == null) {
                    return 'Jumlah wajib diisi';
                  }

                  if (jumlah <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _kategori,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Makanan',
                    child: Text('Makanan'),
                  ),
                  DropdownMenuItem(
                    value: 'Minuman',
                    child: Text('Minuman'),
                  ),
                  DropdownMenuItem(
                    value: 'Lainnya',
                    child: Text('Lainnya'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _kategori = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
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
      ),
    );
  }
}