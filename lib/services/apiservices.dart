import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newswave/models/articlesModel.dart';
import 'package:newswave/models/showcategorymodel.dart';
import 'package:newswave/models/slidermodel.dart';

class Apiservices {
  //Function to get trending news from the API

  Future<News?> getNews() async {
    final getnewsurl = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-07-25&sortBy=publishedAt&apiKey=000802424d224e4895e470e69f4a1e74');
    try {
      //sending a GET request to the API
      final response = await http.get(getnewsurl);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return NewsFromJson(response.body);
      } else {
        print('Failed to load news');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  //Function to get breakingnews from the API
  Future<Slider?> getSlider() async {
    final getsliderurl = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=70738e35ff384ebcb2ff8813bd75002a');
    try {
      //sending a Get request to the API
      final response = await http.get(getsliderurl);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return sliderFromJson(response.body);
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  //Function to get categories news API
  Future<showCatModel?> getcategorynews(String category) async {
    final getcategorynewsurl = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=70738e35ff384ebcb2ff8813bd75002a');
    try {
      print("Fetching news for category: $category");
      print("URL: $getcategorynewsurl");
      final response = await http.get(getcategorynewsurl);
      print("API Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Response body: ${response.body}");
        try {
          final parsedResponse = showCatModelFromJson(response.body);
          print("Parsed articles count: ${parsedResponse.articles.length}");
          return parsedResponse;
        } catch (e) {
          print("Error parsing response: $e");
          print("Response body: ${response.body}");
          return null;
        }
      } else {
        print("API Error: ${response.body}");
      }
    } catch (e) {
      print('Error in getcategorynews: $e');
    }
    return null;
  }
}
