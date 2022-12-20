/// This class represents a Document in the Irs System.
class Document {
  /// The unique ID of the Document in the system
  late final int id;

  /// The name of the Document
  late final String title;

  /// The body of the document
  late final String body;

  /// This is the name of the collection where the document is stored
  // late final String collection;

  /// This is
  late final double ranking;

  /// Creates a new Document
  Document({
    required this.id,
    required this.title,
    required this.body,
    // required this.collection,
  });

  /// Convert the Map representing the Document into a Document object
  Document.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception('The ID of the document is null');
    }
    id = json['id'] as int;
    if (json['title'] == null) {
      throw Exception('The title of the document is null');
    }
    title = json['title'] as String;
    if (json['body'] == null) {
      throw Exception('The body of the document is null');
    }
    body = json['body'] as String;
    if (json['rank'] == null) {
      throw Exception('The ranking of the document is null');
    }
    ranking = json['rank'] as double;
  }
}
