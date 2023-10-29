import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:case_study_latihan/challenge/weather.dart';

class HttpHelper {
  int jlh = 5;

  List results = [];
  
  Future<List?> getWeathers() async {    // pengambilan data melalui web service
    var ids = List.generate(jlh, (index) => 123*index + 1000);
    for (var i = jlh-5; i < jlh; i++) {
      // 79919a1d43cee9b2ad4772f87451ae9b 903507f17d707fecd352d38301efba77
      var id = ids[i];
      var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$id&appid=903507f17d707fecd352d38301efba77');
      http.Response result = await http.get(url);    // ambil data dan return data yg berhasil diterima

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        results.add(Weather.fromJson(jsonResponse));
      }
    }
    return results;
  }
}