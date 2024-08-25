import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newswave/services/apiservices.dart';

class ShowTrendingNews extends StatelessWidget {
  const ShowTrendingNews({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String? image;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: image != null
                  ? CachedNetworkImage(
                      imageUrl: image!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child:
                          Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            description ?? "No description available",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
