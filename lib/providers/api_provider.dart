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
class ModelCollectionInformation {
  /// All the models in the system
  final List<String> allModels;

  /// All the collections in the system
  final List<String> allCollections;

  /// The name of the selected model
  final String modelName;

  /// All the collections selected for the model
  final List<String> selectedCollections;

  const ModelCollectionInformation({
    required this.modelName,
    this.selectedCollections = const [],
    this.allModels = const [],
    this.allCollections = const [],
  });

  /// This creates a new instance of the object overriding some parameters
  ModelCollectionInformation copyWith({
    String? modelName,
    List<String>? selectedCollections,
    List<String>? allModels,
    List<String>? allCollections,
  }) {
    return ModelCollectionInformation(
      modelName: modelName ?? this.modelName,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      allModels: allModels ?? this.allModels,
      allCollections: allCollections ?? this.allCollections,
    );
  }

  //override the == operator
  @override
  bool operator ==(Object other) {
    if (other is! ModelCollectionInformation ||
        _differentModelName(other.modelName) ||
        _differentStringLists(other.selectedCollections, selectedCollections) ||
        _differentStringLists(allModels, other.allModels) ||
        _differentStringLists(allCollections, other.allCollections)) {
      return false;
    }
    return true;
  }

  @override
  // TODO: implement a better hashCode
  int get hashCode {
    return modelName.hashCode +
        selectedCollections.hashCode +
        allModels.hashCode +
        allCollections.hashCode;
  }

  /// This method says if the model name is different from the one in the state
  bool _differentModelName(String modelName) {
    return this.modelName != modelName;
  }

  /// This method says if the collections are different from the ones in the state
  bool _differentStringLists(
      List<String> collections1, List<String> collections2) {
    if (collections1.length != collections2.length) return true;
    return collections1.any((element) => !collections2.contains(element));
  }
}

/// This class is used in a provider
class ModelCollectionInformationNotifier
    extends StateNotifier<ModelCollectionInformation> {
  ModelCollectionInformationNotifier()
      : super(const ModelCollectionInformation(modelName: ''));

  /// This add a collection to the list of collection which are selected
  void addCollection(String collectionName) {
    final collections = state.selectedCollections;
    bool collectionAlreadyAdded = collections.any((c) => c == collectionName);
    if (!collectionAlreadyAdded) {
      state =
          state.copyWith(selectedCollections: [...collections, collectionName]);
    }
  }

  /// This change the selected model
  void changeModel(String modelName) {
    if (state.modelName != modelName) {
      state = state.copyWith(modelName: modelName);
    }
  }

  /// Cambia tanto el modelo como las colecciones y devuelve el estado de la configuración
  ModelCollectionInformation allNew({
    required ModelCollectionInformation newInformation,
  }) {
    if (state != newInformation) {
      state = newInformation;
    }
    return state;
  }
}

/// Do not use this provider directly, use the `getUpdatedModelConfigurationProvider`
final getModelInfoProvider = StateNotifierProvider.autoDispose<
    ModelCollectionInformationNotifier, ModelCollectionInformation>((ref) {
  // final models = ref.watch(getModelsProvider);
  // final collections = ref.watch(getCollectionsProvider);
  return ModelCollectionInformationNotifier();
});

/// This is the provider that needs to be used in all places where the
/// updated configuration of the Model and Collections is needed
final getUpdatedModelCollectionInfoProvider =
    FutureProvider.autoDispose<ModelCollectionInformation>((ref) async {
  final modelConfiguration = ref.watch(getModelInfoProvider);
  final allModels = await IrsApi.getModels();
  ref.keepAlive();
  final allCollections = await IrsApi.getCollections();
  if (allModels.statusCode == 200 && allCollections.statusCode == 200) {
    // Si se pudo obtener los modelos y las colecciones
    var selectedModel = modelConfiguration.modelName;
    final selectedCollections = modelConfiguration.selectedCollections.toList();
    // If for any chance the selected model does not exist in the list of models
    if (!allModels.object!.contains(selectedModel)) {
      selectedModel = allModels.object!.first;
    }
    // If for any chance one of the selected collections do not exist in the list of collections
    for (final collection in selectedCollections) {
      if (!allCollections.object!.contains(collection)) {
        selectedCollections.remove(collection);
      }
    }
    // If for any chance the list of selected collections is empty then add the first collection
    if (selectedCollections.isEmpty) {
      selectedCollections.add(allCollections.object!.first);
    }
    ModelCollectionInformation newConfiguration = ModelCollectionInformation(
      modelName: selectedModel,
      selectedCollections: selectedCollections,
      allModels: allModels.object!,
      allCollections: allCollections.object!,
    );
    // Try to post the new configuration
    final response =
        await IrsApi.postSelectedModel(selectedModel, selectedCollections);

    // If the post was successful then update the state
    if (response.statusCode == 200) {
      return ref
          .watch(getModelInfoProvider.notifier)
          .allNew(newInformation: newConfiguration);
    }
  }
  return modelConfiguration;
});

final postModelConfigurationProvider =
    FutureProvider.autoDispose<IrsResponse<String?>>((ref) async {
  final modelConfiguration = ref.watch(getModelInfoProvider);
  final response = await IrsApi.postSelectedModel(
      modelConfiguration.modelName, modelConfiguration.selectedCollections);
  // ref.keepAlive();
  print('The post response status was: ${response.statusCode}');
  return response;
});

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
    List<Document>? retrievedDocuments,
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

  // int get totalRetrievedDocuments => state..length;

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
  ref.watch(getUpdatedModelCollectionInfoProvider);
  print('El query actual es: ${queryConfiguration.query}');
  final response = await IrsApi.makeQuery(
    query: queryConfiguration.query,
    limit: queryConfiguration.docsPerPage,
    offset: queryConfiguration.pageNumber,
  );
  ref.keepAlive();
  return response;
});
