import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zb_runner/model/discover_response.dart';
import 'package:zb_runner/model/search_res.dart';

import '../model/popular_movie_response.dart';
import '../model/video_respones.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("movie/popular?")
  Future<PopularMovieResponse> getPopularMovies(
      @Query('api_key') String apiKey);

  @GET("movie/550/videos?")
  Future<VideoResponse> getVideos(@Query('api_key') String apiKey);

  @GET("discover/movie?")
  Future<DiscoverResponse> getRandomVid(
      @Query('api_key') String apiKey, @Query("page") String page);

  @GET("search/movie?")
  Future<PopularMovieResponse> searchMovie(
      @Query('api_key') String apiKey, @Query("query") String query);
}

Dio buildDioClient(String base) {
  final dio = Dio()..options = BaseOptions(baseUrl: base);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] =
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1OWJmZWE4NTU3NTNlYjU2YTE0YzdmMmIxZDQ3MGI5NSIsInN1YiI6IjY1ZTA5NDhkMDdlMjgxMDE2M2RjNDFlZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yVSCmhNU_y58B-9BasZ2ZgYuQQsz9rkFL_B8pHbaSX4';
      return handler.next(options);
    },
  ));

  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90));
  return dio;
}

// https://api.themoviedb.org/3/movie/popular?api_key=1e9f47b3229d9660c8e9a91aa9d2c785

// https://api.themoviedb.org/3/movie/550/videos?api_key=1e9f47b3229d9660c8e9a91aa9d2c785

// https://api.themoviedb.org/3/discover/movie?api_key=0ffa014280992f979fa71e8e522ab8d9&page=2

// https://api.themoviedb.org/3/search/movie?api_key=0ffa014280992f979fa71e8e522ab8d9&query=Avengers
