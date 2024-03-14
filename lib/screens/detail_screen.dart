import 'package:flutter/material.dart';
import 'package:jisho/components/header.dart';
import 'package:jisho/models/search_response.dart';
import 'package:jisho/utils/constants.dart';

class DetailScreen extends StatefulWidget {
  final SearchResponse data;
  const DetailScreen(this.data, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                child: Column(children: [
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          widget.data.slug,
                          style: kanji,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(32.0)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                                children: widget.data.senses
                                    .map((sense) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sense.partsOfSpeech.join(", "),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            Text(
                                              sense.englishDefinitions
                                                  .join(", "),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            if (sense.info.isNotEmpty)
                                              Text(
                                                sense.info.first,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            if (sense.seeAlso.isNotEmpty)
                                              Text(
                                                "See also: ${sense.seeAlso.join(", ")}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            const SizedBox(height: 8.0),
                                            if (sense.info.isNotEmpty)
                                              Wrap(
                                                spacing: 8.0,
                                                runSpacing: 4.0,
                                                children: sense.tags
                                                    .map((element) => InputChip(
                                                          selected: true,
                                                          selectedColor: Colors
                                                              .red.shade200,
                                                          showCheckmark: false,
                                                          label: Text(
                                                            element,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            const SizedBox(height: 16.0),
                                          ],
                                        ))
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])),
          )
        ],
      ),
    );
  }
}
