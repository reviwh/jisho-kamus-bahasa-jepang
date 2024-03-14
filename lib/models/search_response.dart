// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

List<SearchResponse> searchResponseFromJson(String str) =>
    List<SearchResponse>.from(
        json.decode(str).map((x) => SearchResponse.fromJson(x)));

String searchResponseToJson(List<SearchResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResponse {
  String slug;
  bool isCommon;
  List<String> tags;
  List<Jlpt> jlpt;
  List<Japanese> japanese;
  List<Sense> senses;
  Attribution attribution;

  SearchResponse({
    required this.slug,
    required this.isCommon,
    required this.tags,
    required this.jlpt,
    required this.japanese,
    required this.senses,
    required this.attribution,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        slug: json["slug"],
        isCommon: json["is_common"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        jlpt: List<Jlpt>.from(json["jlpt"].map((x) => jlptValues.map[x]!)),
        japanese: List<Japanese>.from(
            json["japanese"].map((x) => Japanese.fromJson(x))),
        senses: List<Sense>.from(json["senses"].map((x) => Sense.fromJson(x))),
        attribution: Attribution.fromJson(json["attribution"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "is_common": isCommon,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "jlpt": List<dynamic>.from(jlpt.map((x) => jlptValues.reverse[x])),
        "japanese": List<dynamic>.from(japanese.map((x) => x.toJson())),
        "senses": List<dynamic>.from(senses.map((x) => x.toJson())),
        "attribution": attribution.toJson(),
      };
}

class Attribution {
  bool jmdict;
  bool jmnedict;
  dynamic dbpedia;

  Attribution({
    required this.jmdict,
    required this.jmnedict,
    required this.dbpedia,
  });

  factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        jmdict: json["jmdict"],
        jmnedict: json["jmnedict"],
        dbpedia: json["dbpedia"],
      );

  Map<String, dynamic> toJson() => {
        "jmdict": jmdict,
        "jmnedict": jmnedict,
        "dbpedia": dbpedia,
      };
}

class Japanese {
  String? word;
  String reading;

  Japanese({
    this.word,
    required this.reading,
  });

  factory Japanese.fromJson(Map<String, dynamic> json) => Japanese(
        word: json["word"],
        reading: json["reading"],
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "reading": reading,
      };
}

enum Jlpt { JLPT_N1, JLPT_N2, JLPT_N3, JLPT_N4, JLPT_N5 }

final jlptValues = EnumValues({
  "jlpt-n1": Jlpt.JLPT_N1,
  "jlpt-n2": Jlpt.JLPT_N2,
  "jlpt-n3": Jlpt.JLPT_N3,
  "jlpt-n4": Jlpt.JLPT_N4,
  "jlpt-n5": Jlpt.JLPT_N5
});

class Sense {
  List<String> englishDefinitions;
  List<String> partsOfSpeech;
  List<Link> links;
  List<String> tags;
  List<String> restrictions;
  List<String> seeAlso;
  List<String> antonyms;
  List<Source> source;
  List<String> info;
  List<dynamic>? sentences;

  Sense({
    required this.englishDefinitions,
    required this.partsOfSpeech,
    required this.links,
    required this.tags,
    required this.restrictions,
    required this.seeAlso,
    required this.antonyms,
    required this.source,
    required this.info,
    this.sentences,
  });

  factory Sense.fromJson(Map<String, dynamic> json) => Sense(
        englishDefinitions:
            List<String>.from(json["english_definitions"].map((x) => x)),
        partsOfSpeech: List<String>.from(json["parts_of_speech"].map((x) => x)),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
        restrictions: List<String>.from(json["restrictions"].map((x) => x)),
        seeAlso: List<String>.from(json["see_also"].map((x) => x)),
        antonyms: List<String>.from(json["antonyms"].map((x) => x)),
        source:
            List<Source>.from(json["source"].map((x) => Source.fromJson(x))),
        info: List<String>.from(json["info"].map((x) => x)),
        sentences: json["sentences"] == null
            ? []
            : List<dynamic>.from(json["sentences"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "english_definitions":
            List<dynamic>.from(englishDefinitions.map((x) => x)),
        "parts_of_speech": List<dynamic>.from(partsOfSpeech.map((x) => x)),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "restrictions": List<dynamic>.from(restrictions.map((x) => x)),
        "see_also": List<dynamic>.from(seeAlso.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
        "source": List<dynamic>.from(source.map((x) => x.toJson())),
        "info": List<dynamic>.from(info.map((x) => x)),
        "sentences": sentences == null
            ? []
            : List<dynamic>.from(sentences!.map((x) => x)),
      };
}

class Link {
  String text;
  String url;

  Link({
    required this.text,
    required this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        text: json["text"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "url": url,
      };
}

class Source {
  String language;
  String word;

  Source({
    required this.language,
    required this.word,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        language: json["language"],
        word: json["word"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "word": word,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
