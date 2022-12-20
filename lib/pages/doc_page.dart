import 'package:flutter/material.dart';
import 'package:irs_app/models/document.dart';

class DocPage extends StatelessWidget {
  const DocPage({super.key});

  static String get routeName => '/docPage';

  @override
  Widget build(BuildContext context) {
    final Document document =
        ModalRoute.of(context)!.settings.arguments as Document;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: true,
              titlePadding: const EdgeInsetsDirectional.only(
                  start: 70, bottom: 30, top: 70, end: 20),
              title: Text(
                document.title,
                maxLines: 6,
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.fade,
                  // overflow: TextOverflow.ellipsis,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                document.body.replaceAll(RegExp(r'\n'), ' '),
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
