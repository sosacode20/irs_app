import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/providers/api_provider.dart';

class IrsDrawer extends ConsumerStatefulWidget {
  const IrsDrawer({super.key});

  @override
  ConsumerState<IrsDrawer> createState() => _IrsDrawerState();
}

class _IrsDrawerState extends ConsumerState<IrsDrawer> {
  /// The selected model
  String selectedModel = '';

  /// The selected collection
  String selectedCollection = '';

  @override
  Widget build(BuildContext context) {
    const fontHeadingStyle = TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: 25,
      fontStyle: FontStyle.normal,
    );
    const normalFontStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Lexend',
    );
    final color = Colors.blueGrey[900];

    /// This is for obtaining the info relating with selected model, collection, etc
    final modelCollInfo = ref.watch(getUpdatedModelCollectionInfoProvider);
    return Drawer(
      backgroundColor: Colors.blueGrey[900],
      child: modelCollInfo.when(
        error: (error, stackTrace) {
          print(
              'An Error has ocurred in the SearchPage builder when using the provider: $error');
          return Center(
            child: Text(
              'An Error has ocurred in the SearchPage builder when using the provider: $error',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) {
          // selectedModel = data.modelName;
          return Padding(
            padding: const EdgeInsets.all(30),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: DrawerHeader(
                    child: Text(
                      'General Settings',
                      style: fontHeadingStyle,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildButton(normalFontStyle),
                ),
                SliverToBoxAdapter(
                  child: DropdownButtonFormField<String>(
                    dropdownColor: color,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Model',
                      labelStyle: normalFontStyle,
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value!;
                      });
                    },
                    value: selectedModel == '' ? data.modelName : selectedModel,
                    items: data.allModels.map(
                      (e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: DropdownButtonFormField<String>(
                    // dropdownColor: Colors.transparent,
                    // Change the background color of the dropdown
                    dropdownColor: color,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Collection',
                      labelStyle: normalFontStyle,
                    ),

                    onChanged: (value) {
                      setState(() {
                        selectedCollection = value!;
                      });
                    },
                    value: selectedCollection == ''
                        ? data.selectedCollections[0]
                        : selectedCollection,
                    items: data.allCollections.map(
                      (e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox _buildButton(TextStyle normalFontStyle) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ref.read(getModelInfoProvider.notifier).allNew(
                      newInformation: ModelCollectionInformation(
                        modelName: selectedModel,
                        selectedCollections: [selectedCollection],
                      ),
                    );
              },
              child: Text(
                'Update Settings',
                style: normalFontStyle,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
