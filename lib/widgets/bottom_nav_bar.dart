import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:irs_app/basic_definitions.dart';
import 'package:irs_app/pages/base_page.dart';
import 'package:irs_app/providers/pages_providers.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(pageIndexProvider);
    final pages = ref.watch(pagesProvider);
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: pageIndex,
      items: pages
          .map(
            (page) => BottomNavigationBarItem(
              icon: Icon(page.icon),
              label: page.title,
            ),
          )
          .toList(),
      onTap: (index) {
        setState(() {
          ref.read(pageIndexProvider.notifier).state = index;
          ref.read(pageControllerProvider).animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
        });
      },
    );
  }
}
