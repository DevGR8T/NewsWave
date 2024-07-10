import 'package:flutter/material.dart';
import 'package:newswave/models/showcategorymodel.dart';
import 'package:newswave/pages/trendwebviewpage.dart';
import 'package:newswave/services/apiservices.dart';
import 'package:newswave/widgets/homewidgets/showcategories.dart';
import 'package:newswave/widgets/homewidgets/trendingnews.dart';

class NewsCategoryPage extends StatefulWidget {
  final String catname;

  const NewsCategoryPage({Key? key, required this.catname}) : super(key: key);

  @override
  State<NewsCategoryPage> createState() => _NewsCategoryPageState();
}

class _NewsCategoryPageState extends State<NewsCategoryPage> {
  List<showCat> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    print("Fetching articles for category: ${widget.catname}");
    final showCatModel = await Apiservices().getcategorynews(widget.catname);
    if (showCatModel != null) {
      print("Fetched ${showCatModel.articles.length} articles");
      setState(() {
        articles = showCatModel.articles;
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
          widget.catname,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? LinearProgressIndicator(color: Colors.green)
          : articles.isEmpty
              ? Center(
                  child: Text(
                      "No articles found for ${widget.catname}. Please try another category."))
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrendWebViewPage(
                                url: article.url,
                              ),
                            ));
                      },
                      child: Card(
                        elevation: 2,
                        child: ShowCategory(
                          image: article.urlToImage,
                          title: article.title,
                          description:
                              article.description ?? "No description available",
                          catname: widget.catname,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
