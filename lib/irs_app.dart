import 'package:flutter/material.dart';
import 'package:irs_app/Themes/dark_theme.dart';
import 'package:irs_app/pages/base_page.dart';
import 'package:irs_app/pages/logs_page.dart';
import 'package:irs_app/pages/search_page.dart';
import 'package:irs_app/pages/settings_page.dart';
import 'package:irs_app/widgets/bottom_nav_bar.dart';
import 'package:irs_app/widgets/irs_page_view.dart';

class IrsApp extends StatelessWidget {
  IrsApp({super.key});

  final List<IrsBasePage> _pages = [
    const IrsBasePage(
      title: 'Search',
      icon: Icons.search,
      page: SearchPage(),
    ),
    const IrsBasePage(
      title: 'Logs',
      icon: Icons.list,
      page: LogsPage(),
    ),
    const IrsBasePage(
      title: 'Settings',
      icon: Icons.settings,
      page: SettingsPage(),
    ),
  ];

  void onPageChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRS App',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        // bottomNavigationBar: BottomNavBar(
        //   pages: _pages,
        // ),
        // body: IrsPageView(),
      ),
    );
  }
}
