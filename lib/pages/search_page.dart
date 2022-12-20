import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/providers/api_provider.dart';
import 'package:irs_app/widgets/doc_tile.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(getQueryResultsProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              // color: Theme.of(context).backgroundColor,
            ),
          ), // Background
          Column(
            children: [
              const SearchableBar(),
              results.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (error, stackTrace) {
                  print(
                      'An Error has ocurred in the SearchPage builder when using the provider$error');
                  return const Center(
                    child: Text(
                      'Error',
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                },
                data: (data) {
                  switch (data.statusCode) {
                    case 200:
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.object!.length,
                          itemBuilder: (context, index) {
                            final doc = data.object![index];
                            return DocTile(
                              document: doc,
                              collectionName:
                                  'cran', // TODO: Remove Handcrafting this
                              ranking: 0.3,
                            );
                          },
                        ),
                      );
                    default:
                      return const Center(
                        child: Text(
                          'No Results',
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchableBar extends ConsumerWidget {
  const SearchableBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: _getDecoration(),
      // height: MediaQuery.of(context).size.height * 0.2,
      height: 150,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _getHeader(),
          _getTextField(ref),
        ],
      ),
    );
  }

  /// This returns the TextField that do the search
  Align _getTextField(WidgetRef ref) {
    final textVal = ref.watch(getQueryConfigurationProvider).query;
    return Align(
      alignment: const Alignment(0, 0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: TextField(
          controller: TextEditingController(text: textVal),
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            print(value);
            ref.read(getQueryConfigurationProvider.notifier).changeQuery(value);
          },
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  /// This is the decoration of the background
  BoxDecoration _getDecoration() {
    return BoxDecoration(
      // color: Colors.blue[800],
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      image: const DecorationImage(
        image: AssetImage('assets/images/cover.jpg'),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  /// This is the Header of the Searchable bar
  Align _getHeader() {
    return const Align(
      alignment: Alignment(0, -0.7),
      child: Text(
        'Findit',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontFamily: 'PlayfairDisplay',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
