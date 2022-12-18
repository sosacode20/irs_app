import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:irs_app/api/utils.dart';
import 'package:irs_app/models/document.dart';
// import 'package:irs_app/widgets/doc_tile.dart';
// import

class IrsApi {
  static String get localHostUrl => '0.0.0.0:8000';

  /// Returns a json list of strings representing the models of the system
  static String get getModelsUrl => 'api/model_options';

  /// Returns a json list of strings representing the collections of the system
  static String get getCollectionsUrl => 'api/collection_options';

  /// Returns a json String representing the current selected model in the system
  static String get getSelectedModelUrl => 'api/selected_model';

  /// Represents the base url for telling the system which model we want to use.
  /// We need to add this base url with one of the model names provided by the
  /// `getModels` request, in the following form:
  /// ```dart
  /// final modelName = 'Vector Space Model';
  /// final postAddress = '{IrsApi.postSelectedModel}/{modelName}';
  /// ```
  /// This returns 1 of 2 possible codes.
  /// `200` if everything was ok. `442` if the request was in bad format
  static String get postSelectModelUrl => 'api/select_model';

  /// This is the base url for making queries to the system.
  static String get queryUrl => 'api/query';

  /// Returns a json list of strings representing the models of the system
  static Future<List<String>?> getModels() async {
    print('------------- Get Models ------------');
    var url = Uri.http(localHostUrl, getModelsUrl);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      var models = decodeJsonList(response.body);
      print('Models: $models');
      return models;
    } else {
      print('Error: ${response.body}');
      return [];
    }
  }

  /// This function returns a list of strings representing the collections
  /// in the system
  static Future<List<String>?> getCollections() async {
    var url = Uri.http(localHostUrl, getCollectionsUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var collections = decodeJsonList(response.body);
      print('Collections: $collections');
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<String?> getSelectedModel() async {
    print('------------- Get Selected Model ------------');
    var url = Uri.http(localHostUrl, getSelectedModelUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Selected Model: ${response.body}');
      return response.body;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<void> postSelectedModel(
    String modelName,
    List<String> collections,
  ) async {
    print('------------- Post Selected Model ------------');
    var url = Uri.http(localHostUrl, '$postSelectModelUrl/$modelName');
    var body = json.encode(collections);
    print('La URL es: $url');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('-------------------------------------');
    // print(await http.read(Uri.https
  }

  /// This method is used to make queries to the system.
  static Future<List<Document>?> makeQuery({
    required String query,
    required int limit,
    required int offset,
    int summaryLength = 100,
  }) async {
    var queryParameters = {
      'query': query,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'summary_length': summaryLength.toString(),
    };

    /// This is the url with the query in it
    var url = Uri.http(
      localHostUrl,
      queryUrl,
      queryParameters,
    );
    var body = json.encode(query);
    print('La URL es: $url');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      var docs = decodeJsonList(response.body);
    } else {
      print('Error: ${response.body}');
    }
    print('-------------------------------------');
    // print(await http.read(Uri.https
  }
}
