import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final bool goToSearchPage;
  final String initialSearchPhrase;
  const CustomSearchBar(
      {super.key, this.initialSearchPhrase = "", this.goToSearchPage = true});

  @override
  State<StatefulWidget> createState() => _CustomSearchBar();
}

class _CustomSearchBar extends State<CustomSearchBar> {
  late SearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = SearchController();
    searchController.text = widget.initialSearchPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: SearchAnchor.bar(
            searchController: searchController,
            barHintText: 'Search',
            barLeading: Container(),
            barTrailing: [
              IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      setState(() {
                        if (widget.goToSearchPage) {
                          Navigator.of(context).pushNamed("/search",
                              arguments: searchController.text);
                        } else {
                          // TODO update search results
                        }
                      });
                    } else {
                      searchController.openView();
                    }
                  })
            ],
            viewLeading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => setState(() {
                      if (searchController.text.isEmpty) {
                        searchController.closeView('');
                      } else {
                        searchController.text = '';
                      }
                    })),
            viewTrailing: [
              IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () => setState(() {
                        searchController.closeView(null);

                        if (widget.goToSearchPage) {
                          Navigator.of(context).pushNamed("/search",
                              arguments: searchController.text);
                        } else {
                          // TODO update search results
                        }
                      }))
            ],
            suggestionsBuilder: (context, controller) {
              return [
                // TODO suggestions?
                'suggestions'
              ].map((suggestion) => ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    setState(() {
                      controller.text = suggestion;
                    });
                  }));
            }));
  }
}
