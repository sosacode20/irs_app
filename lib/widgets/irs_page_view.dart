import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/providers/pages_providers.dart';

class IrsPageView extends ConsumerStatefulWidget {
  const IrsPageView({super.key});

  @override
  ConsumerState<IrsPageView> createState() => _IrsPageViewState();
}

class _IrsPageViewState extends ConsumerState<IrsPageView> {
  // final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // final pageIndex = ref.watch(pageIndexProvider);
    final pages = ref.watch(pagesProvider);
    final controller = ref.watch(pageControllerProvider);
    return PageView.builder(
      controller: controller,
      // controller: PageController(initialPage: pageIndex),
      onPageChanged: (index) {
        setState(() {
          ref.read(pageIndexProvider.notifier).state = index;
        });
      },
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return pages[index % pages.length].page;
      },
    );
  }
}
