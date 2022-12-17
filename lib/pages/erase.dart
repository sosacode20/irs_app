import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:irs_app/widgets/Cards/doc_tile.dart';

class Erase extends StatefulWidget {
  const Erase({super.key});

  @override
  State<StatefulWidget> createState() => _EraseState();
}

class _EraseState extends State<Erase> {
  final _wordSuggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          if (index >= _wordSuggestions.length) {
            _wordSuggestions.addAll(
              generateWordPairs().take(20),
            );
          }
          final Document document = Document(
            title: _wordSuggestions[index].asPascalCase,
            body: 'This is the Body of the Document',
          );
          return DocTile(
            document: document,
            collectionName: 'Cran',
            ranking: 0.56782,
          );
        },
      ),
    );
  }
}
