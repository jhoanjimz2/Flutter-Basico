

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/models/models.dart';
import 'package:http/http.dart' as http;


class NewsService with ChangeNotifier {
  final String _baseUrl = 'newsapi.org';
  final String _apiKey = '6a10243031ab4e8f8f81c96d1d3e2c65';
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Article> headlines = [];
  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business' ),
    Category( FontAwesomeIcons.tv, 'entertainment' ),
    Category( FontAwesomeIcons.addressCard, 'general' ),
    Category( FontAwesomeIcons.headSideVirus, 'health' ),
    Category( FontAwesomeIcons.vials, 'science' ),
    Category( FontAwesomeIcons.volleyball, 'sports' ),
    Category( FontAwesomeIcons.memory, 'technology' )
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  List<Article>? get getArticlesCategorySelected => categoryArticles[selectedCategory];

  Future getTopHeadlines() async {
    final url = Uri.https(_baseUrl, '/v2/top-headlines', {'apiKey': _apiKey, 'country': 'CO'});
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  Future getArticlesByCategory(String category) async {
    if ( categoryArticles[category]!.isNotEmpty ) {
        _isLoading = false;
        notifyListeners();
      return categoryArticles[category];
    }
    final url = Uri.https(_baseUrl, '/v2/top-headlines', {'apiKey': _apiKey, 'country': 'CO', 'category': category});
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles);
    _isLoading = false;
    notifyListeners();
  }

}