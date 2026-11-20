import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wearback_mobile/main.dart';

void main() {
  testWidgets('Navigasi ulasan dan kembali tanpa sesi login', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Ulasan & Rating'));
    await tester.pumpAndSettle();
    expect(find.text('Ulasan Saya'), findsOneWidget);
    expect(
      find.text('Silakan login untuk melihat ulasan kamu.'),
      findsOneWidget,
    );
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Wear It Back, Give It Back'), findsOneWidget);
  });
}
