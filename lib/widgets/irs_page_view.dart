import 'package:flutter/material.dart';
import 'package:irs_app/pages/base_page.dart';
import 'package:irs_app/pages/pages.dart';

class IrsPageView extends StatefulWidget {
  const IrsPageView({super.key, required this.pages});

  final List<IrsBasePage> pages;
  @override
  State<IrsPageView> createState() => _IrsPageViewState();
}

class _IrsPageViewState extends State<IrsPageView> {
  final PageController _pageController = PageController(initialPage: 0);

  int _actualPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(initialPage: _actualPageIndex),
      onPageChanged: (index) {
        setState(() {
          _actualPageIndex = index;
        });
      },
      children: widget.pages.map((page) => page.page).toList(),
    );
  }
}
