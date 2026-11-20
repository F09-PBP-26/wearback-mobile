import 'dart:async';
import 'dart:convert';

import '../models/review.dart';

// Modul autentikasi memasok fungsi GET yang membawa sesi pengguna bersama.
// Fungsi tersebut harus meminta JSON, bukan halaman HTML.
typedef ReviewGet = Future<ReviewResponse> Function(Uri uri);

class ReviewResponse {
  final int statusCode;
  final String body;
  const ReviewResponse(this.statusCode, this.body);
}

class ReviewFailure implements Exception {
  final String message;
  const ReviewFailure(this.message);
}

class ReviewService {
  final Uri listEndpoint;
  final ReviewGet get;

  const ReviewService({required this.listEndpoint, required this.get});

  Future<ReviewPage> fetchPage(int page) async {
    if (page < 1) throw ArgumentError.value(page, 'page');
    final uri = listEndpoint.replace(
      queryParameters: {...listEndpoint.queryParameters, 'page': '$page'},
    );
    try {
      final response = await get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 401 || response.statusCode == 403) {
        throw const ReviewFailure('Silakan login untuk melihat ulasan kamu.');
      }
      if (response.statusCode != 200) {
        throw const ReviewFailure('Ulasan belum dapat dimuat. Coba lagi.');
      }
      return ReviewPage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } on ReviewFailure {
      rethrow;
    } on TimeoutException {
      throw const ReviewFailure('Koneksi terlalu lama. Silakan coba lagi.');
    } on FormatException {
      throw const ReviewFailure('Format data ulasan tidak sesuai.');
    } on TypeError {
      throw const ReviewFailure('Format data ulasan tidak sesuai.');
    } catch (_) {
      throw const ReviewFailure('Tidak dapat terhubung. Periksa koneksi kamu.');
    }
  }
}
