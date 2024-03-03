import 'package:flutter/cupertino.dart';
import 'package:zb_runner/model/discover_response.dart';
import 'package:zb_runner/model/search_res.dart';
import 'package:zb_runner/model/video_respones.dart';
import 'package:zb_runner/repository/movie_repo.dart';

import '../model/popular_movie_response.dart';

class MovieViewModel extends ChangeNotifier {
  final _repo = MovieRepository();
  bool loading = false;
  final List<Results> popularMovieList = [];
  final List<Results> popularMovieList1 = [];
  final List<VidResults> vidList = [];
  final List<RanResults> ranVidList = [];

  getPopularMovies()async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
    popularMovieList.addAll(await _repo.getPopularMovie());
    notifyListeners();
  }

  getVideos()async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
    vidList.addAll((await _repo.getVideos()));
    notifyListeners();
  }

  getDisMovie()async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
    ranVidList.addAll((await _repo.getRandom()));
    notifyListeners();
  }

  searchMovies(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    if(query.isNotEmpty){
      loading = true;
      notifyListeners();
      popularMovieList.clear();
      popularMovieList.addAll(await _repo.searchMovie(query));
      loading = false;
      notifyListeners();
    }else{
      popularMovieList.clear();
      popularMovieList.addAll(popularMovieList1);
      loading = false;
      notifyListeners();
    }
  }
}