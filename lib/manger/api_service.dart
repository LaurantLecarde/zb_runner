import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../model/popular_movie_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("popular?")
  Future<PopularMovieResponse> getPopularMovies(
      @Query('api_key') String apiKey);

}

Dio buildDioClient(String base) {
  final dio = Dio()
    ..options = BaseOptions(baseUrl: base);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTlmNDdiMzIyOWQ5NjYwYzhlOWE5MWFhOWQyYzc4NSIsInN1YiI6IjY1ZTA5NDhkMDdlMjgxMDE2M2RjNDFlZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eV53ATnZaT71iBxfWo5jpsssGtFMEdOJbU8FRzIJmSA';
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
      maxWidth: 90
  ));
  return dio;
}

// https://api.themoviedb.org/3/movie/popular?api_key=1e9f47b3229d9660c8e9a91aa9d2c785