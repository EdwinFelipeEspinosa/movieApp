import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:movie_2/models/movie.dart';
import 'package:movie_2/models/now_playing_movie.dart';

class moviePopularProvider extends ChangeNotifier{
  final String _apiKey = '6ae4ba0ab41510d8ce91e355e0b6a511';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> listNowPopularMovies = [];

  moviePopularProvider(){
      getOnDisplayPopularMovie();
  }

  getOnDisplayPopularMovie() async {
    Uri url = Uri.https(
      _baseUrl,
      '3/movie/popular',
      {
        'api_key' : _apiKey,
        'language' : _language,
        'page' : '1'
      }
    );

    Response response = await http.get(url);
    NowPlayingMovie nowPlayingMovie = NowPlayingMovie.fromRawJson(response.body);
    listNowPopularMovies = nowPlayingMovie.results!;
 
    notifyListeners();
  }
}