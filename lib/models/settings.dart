import 'package:irs_app/api/api.dart';

/// This class represents the general settings of the searching
/// in the IRS system
class IrsSettings {
  /// This is the name of the IRS model that is selected in the system
  String selectedModel;

  /// This is the list of collections that are loaded in the model selected
  /// in the system
  List<String> selectedCollections;

  IrsSettings({
    required this.selectedModel,
    required this.selectedCollections,
  });

  Future<void> updateSettings() async {
    var response = await IrsApi.getSelectedModel();
    if (response != null) {
      selectedModel = response;
    }
  }

  /// This method is used to update the settings of the system.
  /// It will update the selected model and the selected collections in the backend
  /// using the corresponding API calls.
  void confirmSettings() async {
    await IrsApi.postSelectedModel(selectedModel, selectedCollections);
  }
}
