import 'package:flutter/material.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ulasan & Rating'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ulasan Saya',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text('Lihat dan kelola ulasan dari pembelian kamu.'),
            SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  Icon(Icons.rate_review_outlined, size: 64),
                  SizedBox(height: 16),
                  Text('Halaman ulasan siap dikembangkan.'),
                  SizedBox(height: 8),
                  Text('Data belum terhubung ke API Django.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
