import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jisho/components/header.dart';
import 'package:jisho/models/search_response.dart';
import 'package:jisho/screens/detail_screen.dart';
import 'package:jisho/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  final String? keyword;
  const HomeScreen({this.keyword, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<SearchResponse>?> getSearch() async {
    String apiUrl = widget.keyword == null
        ? "$url/get-data.php"
        : "$url/get-data.php?keyword=${widget.keyword}";
    try {
      http.Response res = await http.get(Uri.parse(apiUrl));
      return searchResponseFromJson(res.body);
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          const SizedBox(height: 32),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                gradient: RadialGradient(
                  center: const Alignment(.5, -.25),
                  colors: [
                    Colors.red.shade400,
                    Colors.red.shade800,
                  ],
                  stops: const [.75, 1],
                ),
              ),
              child: FutureBuilder(
                  future: getSearch(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SearchResponse>?> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "語彙",
                                  style: kanji,
                                ),
                                const Text(
                                  "Vocabulary",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16.0,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(32.0)),
                                color: Colors.white,
                              ),
                              child: snapshot.data!.isNotEmpty
                                  ? ListView(
                                      children: [
                                        ...List.generate(
                                            snapshot.data?.length ?? 0,
                                            (index) {
                                          SearchResponse? data =
                                              snapshot.data?[index];
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailScreen(
                                                                data!)));
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  data?.slug ?? "",
                                                  style: kanjiSmall,
                                                ),
                                                subtitle: Text(
                                                  data?.senses[0]
                                                          .englishDefinitions
                                                          .join(', ') ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                trailing: const Icon(
                                                    Icons.chevron_right),
                                              ));
                                        }),
                                      ],
                                    )
                                  : const Center(child: Text("No data found")),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
