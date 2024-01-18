import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomSearchBar();
}

class _CustomSearchBar extends State<CustomSearchBar> {
  late SearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = SearchController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SearchAnchor.bar(
            searchController: searchController,
            barHintText: 'Search',
            barLeading: Container(),
            barTrailing: [
              IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      setState(() {});
                    } else {
                      searchController.openView();
                    }
                  })
            ],
            viewLeading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => setState(() {
                      searchController.text = '';
                    })),
            viewTrailing: [
              IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () => setState(() {
                        searchController.closeView(null);
                      }))
            ],
            suggestionsBuilder: (context, controller) {
              return [
                // TODO suggestions?
                'title: ',
                'category: ',
                'description: ',
                'timeRequired: ',
                'deadline(DD/MM/YYYY): ',
                'isRepeating: ',
                'repeatsEvery: ',
                'reminder: ',
                'points: ',
                'isSpecialChallenge: '
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
