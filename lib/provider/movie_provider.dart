import 'package:get/get.dart';
import 'package:movie_trial/mixins/constant/constant.dart';
import 'package:movie_trial/mixins/network/error_handling.dart';
import 'package:movie_trial/mixins/network/interceptor.dart';
import 'package:movie_trial/model/detail_movie.dart';
import 'package:movie_trial/model/res/movie_res.dart';

import '../mixins/logging/logger.dart';

class MovieProvider extends GetConnect {

  @override
  void onInit() {
    super.onInit();
    allowAutoSignedCert = true;
    httpClient.baseUrl = kApiUrl;
    httpClient.timeout = Duration(milliseconds: kConnectionTimeout);
    httpClient.addRequestModifier((request) {
      return requestInterceptor(request);
    });
    httpClient.addResponseModifier((request, response) {
      return responseInterceptor(request, response);
    });
  }

  Future<DetailMovie> geDetailMovie(String id) async {
    final response = await get(
      '/movie/$id',
      query: {
        'api_key':kApiKey
      },
    );
    try {
      return DetailMovie.fromJson(response.body);
    } catch (e, s) {
      logger.e('getDetailMovie', e, s);
      if(response.hasError){
        return Future.error(ErrorHandling(response));
      }else{
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<MovieRes> getTopRatedMovie(int page) async {
    final response = await get(
      '/movie/top_rated',
      query: {
        'page':'$page',
        'api_key':kApiKey
      },
    );
    try {
      return MovieRes.fromJson(response.body);
    } catch (e, s) {
      logger.e('getMoviePopular', e, s);
      if(response.hasError){
        return Future.error(ErrorHandling(response));
      }else{
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }

  Future<MovieRes> getTopRecomendation(int movie_id) async {
    final response = await get(
      '/movie/$movie_id}/recommendations',
      query: {
        'api_key':kApiKey
      },
    );
    try {
      return MovieRes.fromJson(response.body);
    } catch (e, s) {
      logger.e('getRecommendations', e, s);
      if(response.hasError){
        return Future.error(ErrorHandling(response));
      }else{
        return Future.error(ErrorHandling(e.toString()));
      }
    }
  }



}