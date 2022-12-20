import 'package:flutter/material.dart';
import 'package:irs_app/Themes/themes.dart';
import 'package:irs_app/pages/doc_page.dart';
import 'package:irs_app/pages/home_page.dart';

class IrsApp extends StatelessWidget {
  const IrsApp({super.key});

  void onPageChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRS App',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DocPage.routeName: (context) => const DocPage(),
      },
    );
  }
}
