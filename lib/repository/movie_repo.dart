import 'package:zb_runner/manger/api_service.dart';
import 'package:zb_runner/model/popular_movie_response.dart';

class MovieRepository {
  final _api = ApiService(buildDioClient("https://api.themoviedb.org/3/movie/"));
  
  Future<List<Results>> getPopularMovie() async {
    try{
      final response = await _api.getPopularMovies("1e9f47b3229d9660c8e9a91aa9d2c785");
      return response.results ?? [];
    }catch(e){
      print("0000000000000000000------------------00000000000000000000 $e");
      return [];
    }
  }
}

// https://api.themoviedb.org/3/movie/popular?api_key=1e9f47b3229d9660c8e9a91aa9d2c785