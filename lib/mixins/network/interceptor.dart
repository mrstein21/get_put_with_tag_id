import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_trial/mixins/logging/logger.dart';

//request interceptor fungsinya yaitu sebelum ketika setiap request dikirim kan ke server
//request akan melalui fungsi request interceptor ini sehingga kita bisa melihat
//dan maupun logging informasi request mulai dari header,URL API,METHOD yg dipake dan request bodynya
requestInterceptor(Request request) {
  if (kDebugMode) {
    var message = {
      'REQUEST URL:': request.url,
      'REQUEST HEADER:': request.headers,
      'REQUEST METHOD:': request.method,
      'REQUEST BODY':request.bodyBytes
    };
    logger.i(message);
  }
  return request;
}

//response interceptor berfungsi untuk ketika response didapatkan maka response akan menuju
//fungsi responseInterceptor terlebih dahulu sehingga kita bisa melihat atau melogging
// hasil response dari request api serta logging request APInya juga seblum di parsing JSONnya
responseInterceptor(Request request, Response response) {
  ///https://api.themoviedb.org/3/movie/top_rated?api_key=b42f1d2342c381ec25f6180c52e51c00&page=1
  var message = <String, dynamic>{
    'RESPONSE URL:': request.url,
    'RESPONSE CODE:': response.statusCode,
    'RESPONSE MESSAGE:': response.statusText,
    'RESPONSE BODY:': response.body,
    'RESPONSE UNAUTHORIZED:': response.unauthorized,
  };
  logger.i(message);
  return response;
}
