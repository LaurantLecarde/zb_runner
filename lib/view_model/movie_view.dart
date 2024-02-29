import 'package:flutter/cupertino.dart';
import 'package:zb_runner/repository/movie_repo.dart';

import '../model/popular_movie_response.dart';

class MovieViewModel extends ChangeNotifier {
  final _repo = MovieRepository();
  bool loading = false;
  final List<Results> popularMovieList = [];

  getPopularMovies()async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
    popularMovieList.addAll(await _repo.getPopularMovie());
    notifyListeners();
  }
}