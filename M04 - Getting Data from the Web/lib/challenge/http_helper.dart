import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  String _kota = "medan";
  
  Future<double> getWeather() async {    // pengambilan data melalui web service
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$_kota&appid=903507f17d707fecd352d38301efba77');
    http.Response result = await http.get(url);    // ambil data dan return data yg berhasil diterima

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return jsonResponse["main"]["temp"];
    }
    return 0;
  }

  getKota() {
    return _kota;
  }
  
  Future<void> changeKota(newKota) async {
    _kota = newKota;
  }
}