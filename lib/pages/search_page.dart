import 'package:flutter/material.dart';
import 'package:irs_app/widgets/bottom_nav_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      // bottomNavigationBar: const BottomNavBar(index: 1),
    );
  }
}
