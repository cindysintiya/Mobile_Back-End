import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String _urlKey = "?api_key=a97bf83097b68f4265b40280169af7c8";
  final String _urlBase = "https://api.themoviedb.org";
  String _category = "now_playing";

  Future<String> getMovie() async {    // pengambilan data melalui web service
    // var url = Uri.parse(_urlBase + '/3/movie/' + _category + _urlKey);
    var url = Uri.parse('$_urlBase/3/movie/$_category$_urlKey');
    http.Response result = await http.get(url);    // ambil data dan return data yg berhasil diterima

    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }

  getCategory() {
    return _category;
  }

  changeCategory(newCategory) async {
    _category = newCategory;
  }
}