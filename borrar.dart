import 'package:irs_app/api/api.dart' as irsApi;

void main(List<String> args) async {
  await irsApi.IrsApi.getModels();
  await irsApi.IrsApi.getCollections();
  await irsApi.IrsApi.getSelectedModel();
  await irsApi.IrsApi.postSelectedModel('Vector Space Model', ['cran']);
  await irsApi.IrsApi.getSelectedModel();
  await irsApi.IrsApi.makeQuery(query: 'flow past', limit: 10, offset: 0);
}
