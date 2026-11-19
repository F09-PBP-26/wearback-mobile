import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wearback_mobile/main.dart';
import 'package:wearback_mobile/pages/account_page.dart';
import 'package:wearback_mobile/pages/auction_browsing_page.dart';
import 'package:wearback_mobile/pages/auction_detail_page.dart';
import 'package:wearback_mobile/pages/seller_auctions_page.dart';
import 'package:wearback_mobile/pages/transaction_history_page.dart';

void main() {
  testWidgets('Drawer opens each WearBack module and closes on selection', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const WearBackApp());
    expect(find.byType(AuctionBrowsingPage), findsOneWidget);

    const modules = {
      'Detail Lelang & Penawaran': AuctionDetailPage,
      'Manajemen Lelang Penjual': SellerAuctionsPage,
      'Transaksi & Riwayat': TransactionHistoryPage,
      'Autentikasi & Profil': AccountPage,
      'Eksplorasi Lelang': AuctionBrowsingPage,
    };
    final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold));
    final drawer = find.byType(Drawer);
    for (final module in modules.entries) {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      expect(scaffold.isDrawerOpen, isTrue);

      await tester.tap(
        find.descendant(of: drawer, matching: find.text(module.key)),
      );
      await tester.pumpAndSettle();

      expect(scaffold.isDrawerOpen, isFalse);
      expect(find.widgetWithText(AppBar, module.key), findsOneWidget);
      expect(find.byType(module.value), findsOneWidget);
    }
  });
}
