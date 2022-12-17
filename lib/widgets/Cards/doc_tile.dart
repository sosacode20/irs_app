import 'package:flutter/material.dart';

/// This class represents a Document in the IRS
class Document {
  const Document({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

class DocTile extends StatelessWidget {
  const DocTile({
    super.key,
    required this.document,
    required this.collectionName,
    required this.ranking,
  });

  final Document document;
  final String collectionName;
  final double ranking;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.book),
                const SizedBox(width: 8),
                Text(
                  document.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              document.body,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.folder),
                const SizedBox(width: 8),
                Text(
                  collectionName,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  ranking.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
