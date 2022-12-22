import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:irs_app/api/utils.dart';
import 'package:irs_app/models/document.dart';

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

  /// This feature returns a `List<String>?` representing the models of the system.
  /// From this List is from where we select a model with the method `postSelectedModel`
  static Future<IrsResponse<List<String>?>> getModels() async {
    var url = Uri.http(localHostUrl, getModelsUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var models = decodeJsonList(response.body);
      return IrsResponse(statusCode: 200, object: models);
    } else {
      return IrsResponse(statusCode: response.statusCode, object: null);
    }
  }

  // TODO: -------------------------------- Refactor all this code ------------------------------

  /// This function returns a `List<String>?>` of strings representing the collections
  /// in the system.
  static Future<IrsResponse<List<String>?>> getCollections() async {
    var url = Uri.http(localHostUrl, getCollectionsUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var collections = decodeJsonList(response.body);
      return IrsResponse(statusCode: 200, object: collections);
    } else {
      return IrsResponse(statusCode: response.statusCode, object: null);
    }
  }

  /// This feature return a `String` representing the name of the
  /// model selected in the system
  static Future<IrsResponse<String?>> getSelectedModel() async {
    var url = Uri.http(localHostUrl, getSelectedModelUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return IrsResponse(statusCode: 200, object: response.body);
    } else {
      return IrsResponse(statusCode: response.statusCode, object: null);
    }
  }

  /// This feature is for telling the system which of the models
  /// we want to select for the next queries.
  ///
  /// This returns an `http.Response`
  static Future<IrsResponse<String>> postSelectedModel(
    String modelName,
    List<String> collections,
  ) async {
    var url = Uri.http(localHostUrl, '$postSelectModelUrl/$modelName');
    var body = json.encode(collections);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    // return response;
    return IrsResponse(statusCode: response.statusCode, object: response.body);
  }

  /// This method is used to make queries to the system.
  static Future<IrsResponse<List<Document>?>> makeQuery({
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

    /// This is the url with the query parameters in it
    var url = Uri.http(
      localHostUrl,
      queryUrl,
      queryParameters,
    );
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var docs = decodeJsonDocuments(response.body);
      return IrsResponse(statusCode: 200, object: docs);
    } else {
      return IrsResponse(statusCode: response.statusCode, object: null);
    }
    // print(await http.read(Uri.https
  }
}
