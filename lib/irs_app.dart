import 'package:flutter/material.dart';
import 'package:irs_app/Themes/dark_theme.dart';
import 'package:irs_app/widgets/bottom_nav_bar.dart';
import 'package:irs_app/widgets/irs_page_view.dart';

class IrsApp extends StatelessWidget {
  const IrsApp({super.key});

  void onPageChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRS App',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: const Icon(Icons.menu),
        ),
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavBar(),
        body: IrsPageView(),
      ),
    );
  }
}
