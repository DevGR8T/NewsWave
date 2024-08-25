import 'package:flutter/material.dart';
import 'package:newswave/models/articlesModel.dart';
import 'package:newswave/pages/trendwebviewpage.dart';
import 'package:newswave/services/apiservices.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<News?>(
      // Fetch the news data using the Apiservices class
      future: Apiservices().getNews(),
      builder: (BuildContext context, AsyncSnapshot<News?> snapshot) {
        // Show a loading indicator while the data is being fetched
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        } else if (snapshot.hasError) {
          //show an eror mssage if there was an error fetching the data
          return Center(
            child: Text('Error loading news'),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Show a message if no data was returned
          return Center(
            child: Text('No news available'),
          );
        }

        //Store the list of article from the fetched news data
        final news = snapshot.data!.articles;

        return ListView.builder(
          shrinkWrap: true, // Used shrinkWrap to fit the content
          itemCount: news.length, //Number of articles to display
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final article = news[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/trendwebviewpage',
                    arguments: article.url);
              },
              child: Card(
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      if (article.urlToImage != null)
                        Container(
                          margin: EdgeInsets.all(5),
                          height: size.height / 10,
                          width: size.width / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: article.urlToImage!,
                              // Show error icon if image fails to load
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              //show a placeholder while the image is loading
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title ?? 'no Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              article.description ?? 'No Description',
                              style: TextStyle(fontSize: 13),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
