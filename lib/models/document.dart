/// This class represents a Document in the Irs System.
class Document {
  /// The unique ID of the Document in the system
  late final int id;

  /// The name of the Document
  late final String title;

  /// The body of the document
  late final String body;

  /// Creates a new Document
  Document({
    // required this.id,
    required this.title,
    required this.body,
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
  }
}
