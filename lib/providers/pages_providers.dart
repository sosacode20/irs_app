import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/pages/base_page.dart';
import 'package:irs_app/pages/pages.dart';
import 'package:flutter/material.dart';

/// This provider is for pagination
final pageIndexProvider = StateProvider<int>((ref) => 0);

/// This provider give all the pages in the main app
final pagesProvider = Provider<List<IrsBasePage>>((ref) => [
      const IrsBasePage(
        title: 'Settings',
        icon: Icons.settings,
        page: SettingsPage(),
      ),
      const IrsBasePage(
        title: 'Search',
        icon: Icons.search,
        page: SearchPage(),
      ),
      const IrsBasePage(
        title: 'Logs',
        icon: Icons.history,
        page: LogsPage(),
      ),
    ]);

final pageControllerProvider = Provider<PageController>((ref) {
  return PageController(initialPage: 0);
});
