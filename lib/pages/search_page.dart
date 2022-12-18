import 'package:flutter/material.dart';
import 'package:irs_app/models/document.dart';
import 'package:irs_app/widgets/doc_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
          ), // Background
          Column(
            children: [
              const SearchableBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (_, index) {
                    final Document document = Document(
                        id: index,
                        title: 'Doc $index',
                        body: 'Lorem Ipsum blablabla');
                    return DocTile(
                        document: document,
                        collectionName: 'cran',
                        ranking: 0.32);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchableBar extends StatelessWidget {
  const SearchableBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getDecoration(),
      // height: MediaQuery.of(context).size.height * 0.2,
      height: 150,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _getHeader(),
          _getTextField(),
        ],
      ),
    );
  }

  /// This returns the TextField that do the search
  Align _getTextField() {
    return Align(
      alignment: const Alignment(0, 0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: TextField(
          keyboardType: TextInputType.text,
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
        image: AssetImage('assets/image/cover.jpg'),
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
        'Findall',
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
