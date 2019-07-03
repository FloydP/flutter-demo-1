import 'package:dio/dio.dart';

// 请求配置
BaseOptions options = new BaseOptions(
  connectTimeout: 50000,
  receiveTimeout: 30000,
  headers: {
    'content-type': 'application/json;charset=UTF-8',
  },
);

Dio dio = new Dio(options);

Dio injectInterceptors() {
  dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options){
        return options;
      },
      onResponse:(Response response) {
        return response;
      },
      onError: (DioError e) {
        return e;
      }
  ));
  return dio;
}