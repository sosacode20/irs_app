import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/api/api.dart';
import 'package:irs_app/api/utils.dart';
import 'package:irs_app/models/document.dart';

/// This provider is used to fetch the Models from the API
final getModelsProvider =
    FutureProvider.autoDispose<IrsResponse<List<String>?>>((ref) async {
  final response = await IrsApi.getModels();
  ref.keepAlive();
  return response;
});

/// This provider returns all the collections in the system
final getCollectionsProvider =
    FutureProvider.autoDispose<IrsResponse<List<String>?>>((ref) async {
  final response = await IrsApi.getCollections();
  ref.keepAlive();
  return response;
});

final getSelectedModelProvider =
    FutureProvider.autoDispose<IrsResponse<String?>>((ref) async {
  final response = await IrsApi.getSelectedModel();
  ref.keepAlive();
  return response;
});

@immutable
class ModelCollectionConfiguration {
  /// The name of the selected model
  final String modelName;
  final List<String> collections;

  const ModelCollectionConfiguration({
    required this.modelName,
    this.collections = const [],
  });

  /// This creates a new instance of the object overriding some parameters
  ModelCollectionConfiguration copyWith(
      {String? modelName, List<String>? collections}) {
    return ModelCollectionConfiguration(
        modelName: modelName ?? this.modelName,
        collections: collections ?? this.collections);
  }
}

/// This class is used in a provider
class ModelCollectionConfigurationNotifier
    extends StateNotifier<ModelCollectionConfiguration> {
  ModelCollectionConfigurationNotifier()
      : super(const ModelCollectionConfiguration(modelName: ''));

  /// This add a collection to the list of collection which are selected
  void addCollection(String collectionName) {
    final collections = state.collections;
    bool collectionAlreadyAdded = collections.any((c) => c == collectionName);
    if (collectionAlreadyAdded) {
      state = state.copyWith(collections: [...collections]);
    } else {
      state = state.copyWith(collections: [...collections, collectionName]);
    }
  }

  /// This change the selected model
  void changeModel(String modelName) {
    if (state.modelName != modelName) {
      state = state.copyWith(modelName: modelName);
    }
  }
}

/// This provider is for the user see the selected model and collections in
/// the system
final getModelConfigurationProvider = StateNotifierProvider.autoDispose<
        ModelCollectionConfigurationNotifier, ModelCollectionConfiguration>(
    (ref) => ModelCollectionConfigurationNotifier());

class QueryConfiguration {
  /// This is the query that the user want to consult
  final String query;

  /// This is the number of results per page that the user want to see
  final int docsPerPage;

  /// This is the page that the user want to see
  final int pageNumber;

  const QueryConfiguration({
    this.query = '',
    this.docsPerPage = 10,
    this.pageNumber = 0,
  });

  /// This creates a new instance of the object overriding some parameters
  QueryConfiguration copyWith({
    String? query,
    int? docsPerPage,
    int? pageNumber,
  }) {
    return QueryConfiguration(
      query: query ?? this.query,
      docsPerPage: docsPerPage ?? this.docsPerPage,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}

class QueryConfigurationNotifier extends StateNotifier<QueryConfiguration> {
  QueryConfigurationNotifier() : super(const QueryConfiguration());

  /// This change the query
  void changeQuery(String query) {
    if (state.query != query) {
      state = state.copyWith(query: query);
    }
  }

  /// This change the number of docs per page
  void changeDocsPerPage(int docsPerPage) {
    if (state.docsPerPage != docsPerPage) {
      state = state.copyWith(docsPerPage: docsPerPage);
    }
  }

  /// This change the page number
  void changePageNumber(int pageNumber) {
    if (state.pageNumber != pageNumber) {
      state = state.copyWith(pageNumber: pageNumber);
    }
  }
}

/// This provider is for the user see the query that he is consulting
final getQueryConfigurationProvider = StateNotifierProvider.autoDispose<
    QueryConfigurationNotifier,
    QueryConfiguration>((ref) => QueryConfigurationNotifier());

final getQueryResultsProvider =
    FutureProvider.autoDispose<IrsResponse<List<Document>?>>((ref) async {
  final queryConfiguration = ref.watch(getQueryConfigurationProvider);
  // final modelCollectionConfiguration =
  //     ref.watch(getModelConfigurationProvider);
  print('El query actual es: ${queryConfiguration.query}');
  final response = await IrsApi.makeQuery(
    query: queryConfiguration.query,
    limit: queryConfiguration.docsPerPage,
    offset: queryConfiguration.pageNumber,
  );
  // ref.keepAlive();
  return response;
});
