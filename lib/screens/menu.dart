import 'package:flutter/material.dart';
import '../widgets/item_card.dart';
import '../widgets/left_drawer.dart';
import 'news_form_page.dart';

// --- Data tombol grid
class ItemHomepage {
  final String name;
  final IconData icon;
  ItemHomepage(this.name, this.icon);
}

// --- Kartu info identitas (boleh tetap di file ini)
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Isi identitasmu
    const npm = "2406351453";
    const nama = "Rivaldy Putra Rivly";
    const kelas = "B";

    final items = [
      ItemHomepage("See Football News", Icons.newspaper),
      ItemHomepage("Add News", Icons.add),
      ItemHomepage("Logout", Icons.logout),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Football News', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 3 kartu identitas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16),
            // Grid 3 tombol
            GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: items.map((e) {
                return ItemCard(
                  title: e.name,
                  icon: e.icon,
                  onTap: () {
                    if (e.name == "Add News") {
                      // dari grid pakai push (bisa back ke Home)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NewsFormPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text("Kamu menekan tombol ${e.name}!")),
                        );
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
