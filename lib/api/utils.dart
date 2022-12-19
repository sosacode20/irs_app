import 'dart:convert';

import 'package:irs_app/models/document.dart';

/// Decode a json string into a List of Strings.
/// Useful for decoding the list of models and collections
List<String> decodeJsonList(String json) {
  var list = jsonDecode(json) as List;
  return list.map((e) => e.toString()).toList();
}

/// Decode a json string into a List of Documents.
List<Document> decodeJsonDocuments(String json) {
  var list = jsonDecode(json) as List;
  return list
      .map(
        (e) => Document.fromJson(e as Map<String, dynamic>),
      )
      .toList();
}

/// This class is a Wrapper to a Response which could return a different Object
/// depending of the status code. This class *should* be used as return value
/// of `Feature` that make an http request.
class IrsResponse<T> {
  /// This is the status code returned by an http request
  final int statusCode;
  final T object;

  const IrsResponse({
    required this.statusCode,
    required this.object,
  });
}
