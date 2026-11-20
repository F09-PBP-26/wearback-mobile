import 'package:flutter/material.dart';

import '../../models/review.dart';
import '../../services/review_service.dart';

class ReviewListPage extends StatefulWidget {
  // Diisi saat modul login bersama dan alamat API sudah diintegrasikan.
  final ReviewService? service;
  const ReviewListPage({super.key, this.service});

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  ReviewPage? _data;
  String? _error;
  bool _loading = false;
  int _page = 1;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _load(1);
  }

  @override
  void didUpdateWidget(covariant ReviewListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.service != widget.service) {
      _data = null;
      _load(1);
    }
  }

  Future<void> _load(int page) async {
    final request = ++_request;
    final service = widget.service;
    if (service == null) {
      setState(() {
        _data = null;
        _error = null;
        _loading = false;
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await service.fetchPage(page);
      if (!mounted || request != _request) return;
      setState(() {
        _data = data;
        _page = page;
        _loading = false;
      });
    } on ReviewFailure catch (error) {
      if (!mounted || request != _request) return;
      setState(() {
        _data = null;
        _error = error.message;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ulasan & Rating')),
      body: RefreshIndicator(
        onRefresh: () => _load(1),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Ulasan Saya',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text('Lihat ulasan dari pembelian kamu.'),
            const SizedBox(height: 24),
            if (widget.service == null) ...[
              const Icon(Icons.lock_outline, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Silakan login untuk melihat ulasan kamu.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Fitur login aplikasi belum tersedia.',
                textAlign: TextAlign.center,
              ),
            ] else if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null) ...[
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Center(
                child: OutlinedButton(
                  onPressed: () => _load(_page),
                  child: const Text('Coba lagi'),
                ),
              ),
            ] else if (_data != null) ...[
              Text('${_data!.count} ulasan'),
              const SizedBox(height: 12),
              if (_data!.reviews.isEmpty)
                const Text(
                  'Belum ada ulasan. Kamu dapat mengulas setelah transaksi selesai.',
                ),
              for (final review in _data!.reviews) _reviewCard(review),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: _page > 1 ? () => _load(_page - 1) : null,
                    child: const Text('Sebelumnya'),
                  ),
                  Text('Halaman $_page'),
                  OutlinedButton(
                    onPressed: _data!.hasNext ? () => _load(_page + 1) : null,
                    child: const Text('Berikutnya'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _reviewCard(Review review) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.productName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Semantics(
            label: '${review.rating} dari 5 bintang',
            child: ExcludeSemantics(
              child: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: const Color(0xFF916200),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(review.comment),
          ],
          if (review.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [for (final tag in review.tags) Chip(label: Text(tag))],
            ),
          ],
        ],
      ),
    ),
  );
}
