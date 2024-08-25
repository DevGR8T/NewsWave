import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as Carousel;
import 'package:newswave/models/slidermodel.dart';
import 'package:newswave/services/apiservices.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BreakingNews extends StatefulWidget {
  const BreakingNews({super.key});

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  int activeIndex = 0; // Tracks the currently active slide index
  List<Headline> articles = []; // Stores the list of news headlines
  bool isLoading = true; // Indicates whether data is being loaded

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchheadline(); // Fetch headlines when the widget initializes
  }

  Future<void> fetchheadline() async {
    setState(() {
      isLoading = true;
    });
    final slider = await Apiservices().getSlider();
    if (slider != null) {
      setState(() {
        articles = slider.articles;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 315,
        width: double.infinity,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.green,
              ))
            : articles.isEmpty
                ? Center(
                    child: Text('No headnews available'),
                  )
                : Stack(
                    children: [
                      // Carousel Slider for displaying news articles
                      Carousel.CarouselSlider.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index, realIndex) {
                          final article = articles[index];
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              // Displays the article image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage ?? '',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey[300],
                                    child: Icon(Icons.error, color: Colors.red),
                                  ),
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[300],
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                              ),
                              // Gradient overlay for better text visibility
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7)
                                    ],
                                  ),
                                ),
                              ),
                              // Displays the article title
                              Positioned(
                                left: 15,
                                right: 15,
                                bottom: 15,
                                child: Text(
                                  article.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3.0,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                        options: Carousel.CarouselOptions(
                          height: 300,
                          viewportFraction: 0.9,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        ),
                      ),
                      // Page indicator dots
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedSmoothIndicator(
                            activeIndex: activeIndex,
                            count: articles.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.white.withOpacity(0.5),
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
  }
}
