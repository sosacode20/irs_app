import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irs_app/providers/api_provider.dart';
import 'package:irs_app/widgets/doc_tile.dart';
import 'package:irs_app/widgets/irs_drawer.dart';
import 'package:number_selector/number_selector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// The name of the route
  static String get routeName => '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: IrsDrawer(),
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends ConsumerWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryResults = ref.watch(getQueryResultsProvider);
    final modelCollInfo = ref.watch(getModelInfoProvider);
    return CustomScrollView(
      slivers: [
        _createSliverAppBar(context, ref),
        queryResults.when(
          loading: () => const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) {
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
                        collectionName: modelCollInfo.selectedCollections[0],
                        ranking: doc.ranking,
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
        SliverToBoxAdapter(
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(10),
            // color: Colors.red,
            child: NumberSelector(
              min: 0,
              max: 10,
              current: 0,
              backgroundColor: Colors.transparent,
              iconColor: Colors.white,
              onUpdate: (number) async {},
            ),
          ),
        ),
      ],
    );
  }

  /// Creates the Sliver App Bar that contains the TextField for Searching
  Widget _createSliverAppBar(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      // backgroundColor: Colors.transparent,
      backgroundColor: const Color.fromARGB(255, 16, 25, 29),
      elevation: 2,
      forceElevated: true,
      expandedHeight: 200,
      floating: true,
      pinned: true,
      snap: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        // centerTitle: true,
        background: Image.asset(
          'assets/images/cover.jpg',
          fit: BoxFit.cover,
        ),
        title: _buildHeadingText(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: _buildTextField(context, ref),
      ),
      toolbarHeight: 100,
      // Add a search
    );
  }
}

/// This build the default Search Field
PreferredSizeWidget _buildTextField(BuildContext context, WidgetRef ref) {
  var textStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'Lexend',
  );
  return AppBar(
    automaticallyImplyLeading: false,
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
