import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/providers/api_provider.dart';
import 'package:irs_app/widgets/doc_tile.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  /// The name of the route
  static String get routeName => '/';

  /// This build the default Search Field
  PreferredSizeWidget _buildTextField(WidgetRef ref) {
    var textStyle = const TextStyle(
      fontSize: 20,
      fontFamily: 'Lexend',
    );
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TextField(
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          ref.read(getQueryConfigurationProvider.notifier).changeQuery(value);
        },
        style: textStyle,
        decoration: InputDecoration(
          labelText: 'Search for documents',
          labelStyle: textStyle,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 15,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// This builds the name of the Sliver App Bar
  Widget _buildHeadingText(BuildContext context) {
    return Text(
      'Findit',
      style: Theme.of(context).textTheme.headline1,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docs = ref.watch(getQueryResultsProvider);
    return Scaffold(
      body: CustomScrollView(
        // controller: ScrollController(), // TODO: Add this to a provider
        slivers: [
          SliverAppBar(
            // backgroundColor: Colors.transparent,
            backgroundColor: Color.fromARGB(255, 16, 25, 29),
            elevation: 2,
            forceElevated: true,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              // centerTitle: true,
              background: Image.asset(
                'assets/images/cover.jpg',
                fit: BoxFit.cover,
              ),
              title: _buildHeadingText(context),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: _buildTextField(ref),
            ),
            toolbarHeight: 100,
            // Add a search
          ),
          // SliverList(),
          docs.when(
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stackTrace) {
              print(
                  'An Error has ocurred in the SearchPage builder when using the provider$error');
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Error',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              );
            },
            data: (data) {
              switch (data.statusCode) {
                case 200:
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final doc = data.object![index];
                        return DocTile(
                          document: doc,
                          collectionName:
                              'cran', // TODO: Remove Handcrafting this
                          ranking: 0.3,
                        );
                      },
                      childCount: data.object!.length,
                    ),
                  );
                default:
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Results',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
