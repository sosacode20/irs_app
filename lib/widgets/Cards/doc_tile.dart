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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        // constraints: const BoxConstraints(
        //   maxHeight: 100,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              document.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              document.body,
              style: const TextStyle(
                fontSize: 15,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  collectionName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ranking.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
