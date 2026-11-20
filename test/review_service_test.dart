import 'package:flutter_test/flutter_test.dart';
import 'package:wearback_mobile/services/review_service.dart';

void main() {
  test('Membaca pagination JSON dan mengirim nomor halaman', () async {
    final service = ReviewService(
      listEndpoint: Uri.parse('https://example.test/api/reviews/'),
      get: (uri) async {
        expect(uri.queryParameters['page'], '2');
        return const ReviewResponse(
          200,
          '{"count":1,"next":null,"results":[{"id":2,"product_name":"Jaket",'
          '"rating":5,"comment":"Sesuai","tags":["Quality"]}]}',
        );
      },
    );
    final page = await service.fetchPage(2);
    expect(page.reviews.single.productName, 'Jaket');
    expect(page.reviews.single.rating, 5);
    expect(page.hasNext, false);
  });

  test('Akses tanpa login menjadi pesan yang dapat ditampilkan', () async {
    final service = ReviewService(
      listEndpoint: Uri.parse('https://example.test/api/reviews/'),
      get: (_) async => const ReviewResponse(403, '{}'),
    );
    await expectLater(service.fetchPage(1), throwsA(isA<ReviewFailure>()));
  });

  test('HTML tidak dianggap data ulasan', () async {
    final service = ReviewService(
      listEndpoint: Uri.parse('https://example.test/api/reviews/'),
      get: (_) async => const ReviewResponse(200, '<html>Login</html>'),
    );
    await expectLater(service.fetchPage(1), throwsA(isA<ReviewFailure>()));
  });
}
