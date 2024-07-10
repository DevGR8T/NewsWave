import 'package:flutter/material.dart';
import 'package:newswave/pages/newscategorypage.dart';

class NewsCategories extends StatelessWidget {
  NewsCategories({super.key});

  final List<Map<String, String>> categories = [
    {'title': 'Business', 'image': 'images/business.jpeg'},
    {'title': 'Entertainment', 'image': 'images/entertainment.jpg'},
    {'title': 'General', 'image': 'images/general.jpeg'},
    {'title': 'Health', 'image': 'images/health.png'},
    {'title': 'Sports', 'image': 'images/sports.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsCategoryPage(
                    catname: categories[index]['title'] ?? 'Unknown',
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 7),
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: [
                    //categories image
                    Container(
                      width: 130,
                      child: Image.asset(
                        categories[index]['image'] ?? 'images/default.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),

                    //Semi-transparent over lay
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    //Text
                    Center(
                      child: Text(
                        categories[index]['title'] ?? 'unknown',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
