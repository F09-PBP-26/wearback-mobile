import 'package:flutter/material.dart';
import 'package:wearback_mobile/pages/account_page.dart';
import 'package:wearback_mobile/pages/transaction_history_page.dart';
import 'package:wearback_mobile/screens/reviews/review_list_page.dart';
import 'package:wearback_mobile/widgets/module_placeholder.dart';
import 'package:wearback_mobile/pages/dropoff_page.dart';

enum _Module {
  accountAndAuction(
    'Autentikasi, Profil & Auction',
    Icons.person_outline,
    AccountPage(),
  ),
  catalog(
    'Katalog & Listing Pakaian',
    Icons.checkroom_outlined,
    ModulePlaceholder('Katalog dan listing pakaian sedang disiapkan.'),
  ),
  reviews(
    'Ulasan & Rating Penjual',
    Icons.rate_review_outlined,
    ReviewListPage(),
  ),
  transactions(
    'Transaksi & Riwayat',
    Icons.receipt_long,
    TransactionHistoryPage(),
  ),
  dropOff(
    'Lokasi Drop-off & Pengiriman',
    Icons.location_on_outlined,
    DropoffPage(),
  );

  const _Module(this.title, this.icon, this.page);

  final String title;
  final IconData icon;
  final Widget page;
}

class ModuleShell extends StatefulWidget {
  const ModuleShell({super.key});

  @override
  State<ModuleShell> createState() => _ModuleShellState();
}

class _ModuleShellState extends State<ModuleShell> {
  _Module _selectedModule = _Module.catalog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedModule.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text('WearBack', style: theme.textTheme.titleLarge),
              ),
              for (final module in _Module.values)
                ListTile(
                  leading: Icon(module.icon),
                  title: Text(module.title),
                  shape: const StadiumBorder(),
                  selected: module == _selectedModule,
                  selectedColor: theme.colorScheme.onSecondaryContainer,
                  selectedTileColor: theme.colorScheme.secondaryContainer,
                  onTap: () {
                    setState(() => _selectedModule = module);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _selectedModule.page),
    );
  }
}
