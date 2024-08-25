import 'package:flutter/material.dart';
import 'package:newswave/pages/allbreaknewspage.dart';
import 'package:newswave/pages/alltrendingnewspage.dart';
import 'package:newswave/widgets/homewidgets/breakingnews.dart';
import 'package:newswave/widgets/homewidgets/newscategories.dart';
import 'package:newswave/widgets/homewidgets/trendingnews.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    //Stimulating loading data with a delay of 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Update isLoading to false when data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while isLoading is true
    if (isLoading) {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: Colors.green,
        )),
      );
    }
    // Once isLoading is false, show the actual content
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Wave',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsCategories(),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    'Breaking News!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/headnews');
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            BreakingNews(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending News!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/trends');
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
            TrendingNews(),
          ],
        ),
      ),
    );
  }
}
