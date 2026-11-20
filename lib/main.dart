import 'package:flutter/material.dart';
import 'screens/reviews/review_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WearBack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF294439),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F5F0),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WearBack')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Wear It Back, Give It Back',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.rate_review_outlined),
              title: const Text('Ulasan & Rating'),
              subtitle: const Text('Lihat dan kelola ulasan pembelian'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ReviewListPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
