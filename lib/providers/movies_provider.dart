import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = dotenv.get('API_KEY');
  String _baseUrl = dotenv.get('BASE_URL');
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    var response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    if (response.statusCode != 200) return print('error');
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    var response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    if (response.statusCode != 200) return print('error');
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
