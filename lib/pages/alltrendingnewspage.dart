import 'package:flutter/material.dart';
import 'package:newswave/models/articlesModel.dart';
import 'package:newswave/models/showcategorymodel.dart';
import 'package:newswave/pages/trendwebviewpage.dart';
import 'package:newswave/services/apiservices.dart';
import 'package:newswave/widgets/homewidgets/showcategories.dart';
import 'package:newswave/widgets/homewidgets/showtrendingnews.dart';

class AllTrendingNews extends StatefulWidget {
  const AllTrendingNews({
    Key? key,
  }) : super(key: key);

  @override
  State<AllTrendingNews> createState() => _AllTrendingNewsState();
}

class _AllTrendingNewsState extends State<AllTrendingNews> {
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final news = await Apiservices().getNews();
    if (news != null) {
      setState(() {
        articles = news.articles;
        isLoading = false;
      });
    } else {
      print("Failed to fetch articles");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trending News',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? LinearProgressIndicator(color: Colors.green)
          : articles.isEmpty
              ? Center(child: Text("No articles found "))
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return InkWell(
                      onTap: () {
                        if (article.url != null && article.url!.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TrendWebViewPage(url: article.url!),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('article Url not available')));
                        }
                      },
                      child: Card(
                        elevation: 2,
                        child: ShowTrendingNews(
                          image: article.urlToImage,
                          title: article.title ?? 'No title available',
                          description:
                              article.description ?? "No description available",
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
