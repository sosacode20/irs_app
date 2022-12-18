import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/api/api.dart';

/// This provider is used to fetch the Models from the API
final getModelsProvider =
    FutureProvider.autoDispose<List<String>?>((ref) async {
  final response = await IrsApi.getModels();
  ref.keepAlive();
  return response;
});

final getCollectionsProvider =
    FutureProvider.autoDispose<List<String>?>((ref) async {
  final response = await IrsApi.getCollections();
  ref.keepAlive();
  return response;
});
