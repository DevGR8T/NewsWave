import 'dart:convert';

showCatModel showCatModelFromJson(String str) =>
    showCatModel.fromJson(json.decode(str));

class showCatModel {
  String status;
  int totalResults;
  List<showCat> articles;

  showCatModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory showCatModel.fromJson(Map<String, dynamic> json) {
    return showCatModel(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: List<showCat>.from(
          json["articles"]?.map((x) => showCat.fromJson(x)) ?? []),
    );
  }
}

class showCat {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  showCat({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory showCat.fromJson(Map<String, dynamic> json) => showCat(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"] ?? "",
        description: json["description"],
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(
            json["publishedAt"] ?? DateTime.now().toIso8601String()),
        content: json["content"],
      );
}

class Source {
  String? id; // Make id nullable
  String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"] ?? "", // Provide a default value if null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
