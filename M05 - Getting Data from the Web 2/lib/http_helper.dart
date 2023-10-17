import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:case_study_latihan/movie.dart';

class HttpHelper {
  final String _urlKey = "?api_key=a97bf83097b68f4265b40280169af7c8";
  final String _urlBase = "https://api.themoviedb.org";
  String _category = "now_playing";

  Future<List?> getMovies() async {    // pengambilan data melalui web service
    // var url = Uri.parse(_urlBase + '/3/movie/' + _category + _urlKey);
    var url = Uri.parse('$_urlBase/3/movie/$_category$_urlKey');
    http.Response result = await http.get(url);    // ambil data dan return data yg berhasil diterima

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return null;
  }

  getCategory() {
    return _category;
  }

  Future<void> changeCategory(newCategory) async {
    _category = newCategory;
  }
}