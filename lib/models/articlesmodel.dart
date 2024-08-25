import 'dart:convert';

News NewsFromJson(String str) => News.fromJson(json.decode(str));

String NewsToJson(News data) => json.encode(data.toJson());

class News {
  String status;
  int totalResults;
  List<ArticleModel> articles;

  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleModel>.from(
            json["articles"].map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class ArticleModel {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: json["source"] != null ? Source.fromJson(json["source"]) : null,
        author: json["author"] as String?,
        title: json["title"] as String?,
        description: json["description"] as String?,
        url: json["url"] as String?,
        urlToImage: json["urlToImage"] as String?,
        publishedAt: json["publishedAt"] != null
            ? DateTime.parse(json["publishedAt"])
            : null,
        content: json["content"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}

class Source {
  dynamic id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
