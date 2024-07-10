import 'package:flutter/material.dart';
import 'package:newswave/models/showcategorymodel.dart';
import 'package:newswave/models/slidermodel.dart';
import 'package:newswave/pages/trendwebviewpage.dart';
import 'package:newswave/services/apiservices.dart';
import 'package:newswave/widgets/homewidgets/showbreakingnews.dart';
import 'package:newswave/widgets/homewidgets/showcategories.dart';

class AllBreakingNews extends StatefulWidget {
  const AllBreakingNews({
    Key? key,
  }) : super(key: key);

  @override
  State<AllBreakingNews> createState() => _AllBreakingNewsState();
}

class _AllBreakingNewsState extends State<AllBreakingNews> {
  List<Headline> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    final slider = await Apiservices().getSlider();
    if (slider != null) {
      setState(() {
        articles = slider.articles;
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
          'Breaking News',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TrendWebViewPage(url: article.url!),
                            ));
                      },
                      child: Card(
                        elevation: 2,
                        child: ShowBreakingNews(
                          image: article.urlToImage,
                          title: article.title,
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
