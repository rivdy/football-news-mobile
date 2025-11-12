import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';

class NewsFormPage extends StatefulWidget {
  const NewsFormPage({super.key});

  @override
  State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _content = "";
  String _category = "update";     // default
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'transfer', 'update', 'exclusive', 'match', 'rumor', 'analysis'
  ];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Berita berhasil disimpan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul: $_title'),
                Text('Isi: $_content'),
                Text('Kategori: $_category'),
                Text('Thumbnail: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
                Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
          ],
        ),
      );

      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _title = "";
        _content = "";
        _category = "update";
        _thumbnail = "";
        _isFeatured = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Berita')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Judul
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Judul Berita",
                    labelText: "Judul",
                  ),
                  onChanged: (v) => setState(() => _title = v),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "Judul tidak boleh kosong" : null,
                ),
              ),
              // Isi
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Isi berita",
                    labelText: "Isi",
                  ),
                  onChanged: (v) => setState(() => _content = v),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "Isi tidak boleh kosong" : null,
                ),
              ),
              // Kategori
              Padding(
                padding: const EdgeInsets.all(8),
                child: DropdownButtonFormField<String>(
                  value: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                  decoration: const InputDecoration(labelText: "Kategori"),
                ),
              ),
              // Thumbnail (opsional)
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "URL Thumbnail (opsional)",
                    labelText: "URL Thumbnail",
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (v) => setState(() => _thumbnail = v),
                ),
              ),
              // Unggulan
              Padding(
                padding: const EdgeInsets.all(8),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Berita Unggulan"),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v),
                ),
              ),
              // Simpan
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
