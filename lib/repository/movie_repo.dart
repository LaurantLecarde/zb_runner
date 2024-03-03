import 'package:zb_runner/manger/api_service.dart';
import 'package:zb_runner/model/discover_response.dart';
import 'package:zb_runner/model/popular_movie_response.dart';
import 'package:zb_runner/model/search_res.dart';
import 'package:zb_runner/model/video_respones.dart';

class MovieRepository {
  final _api = ApiService(buildDioClient("https://api.themoviedb.org/3/"));
  
  Future<List<Results>> getPopularMovie() async {
    try{
      final response = await _api.getPopularMovies("59bfea855753eb56a14c7f2b1d470b95");
      return response.results ?? [];
    }catch(e){
      print("0000000000000000000------------------00000000000000000000 $e");
      return [];
    }
  }

  Future<List<VidResults>> getVideos()async {
    try{
      final response = await _api.getVideos("59bfea855753eb56a14c7f2b1d470b95");
      return response.vidResults ?? [];
    }catch(e){
      print("0000000000000000000------------------00000000000000000000 $e");
      return [];
    }
  }

  Future<List<RanResults>> getRandom()async {
    try{
      final response = await _api.getRandomVid("59bfea855753eb56a14c7f2b1d470b95", "2");
      return response.ranResults ??[];
    }catch(e){
      print("0000000000000000000------------------00000000000000000000 $e");
      return [];
    }
  }

  Future<List<Results>> searchMovie(String query) async {
    try{
      final response = await _api.searchMovie("59bfea855753eb56a14c7f2b1d470b95", query);
      return response.results ?? [];
    }catch(e){
      print("0000000000000000000------------------00000000000000000000 $e");
      return [];
    }
  }
}

// https://api.themoviedb.org/3/movie/popular?api_key=0ffa014280992f979fa71e8e522ab8d9
// https://api.themoviedb.org/3/movie/550/videos?api_key=1e9f47b3229d9660c8e9a91aa9d2c785