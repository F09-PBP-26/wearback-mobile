import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wearback_mobile/main.dart';
import 'package:wearback_mobile/pages/account_page.dart';
import 'package:wearback_mobile/pages/transaction_history_page.dart';
import 'package:wearback_mobile/screens/reviews/review_list_page.dart';
import 'package:wearback_mobile/widgets/module_placeholder.dart';

void main() {
  testWidgets('Drawer opens each module in the current README scope', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const WearBackApp());
    expect(find.byType(ModulePlaceholder), findsOneWidget);

    const modules = {
      'Autentikasi, Profil & Auction': AccountPage,
      'Katalog & Listing Pakaian': ModulePlaceholder,
      'Ulasan & Rating Penjual': ReviewListPage,
      'Transaksi & Riwayat': TransactionHistoryPage,
      'Lokasi Drop-off & Pengiriman': ModulePlaceholder,
    };
    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    final drawer = find.byType(Drawer);
    for (final module in modules.entries) {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      expect(scaffold.isDrawerOpen, isTrue);

      final menu = find.descendant(of: drawer, matching: find.text(module.key));
      await tester.ensureVisible(menu);
      await tester.tap(menu);
      await tester.pumpAndSettle();

      expect(scaffold.isDrawerOpen, isFalse);
      expect(find.widgetWithText(AppBar, module.key), findsOneWidget);
      expect(find.byType(module.value), findsOneWidget);
    }
  });
}
