import 'package:flutter/material.dart';
import 'package:irs_app/basic_definitions.dart';
import 'package:irs_app/pages/base_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.pages,
    required this.onPageChanged,
  }) : super(key: key);

  /// The pages that will be in the bottom navigation bar.
  final List<IrsBasePage> pages;
  final OnPageChanged onPageChanged;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _index,
      items: widget.pages
          .map(
            (page) => BottomNavigationBarItem(
              icon: Icon(page.icon),
              label: page.title,
            ),
          )
          .toList(),
      onTap: (index) {
        setState(() {
          _index = index;
        });
      },
    );
  }
}
