import 'package:dio/dio.dart';
import 'package:frontend/util/debug_print.dart';
import 'package:frontend/util/net/response_interceptors.dart';
import 'package:frontend/util/net/result_data.dart';

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  Dio? _dio;

  HttpManager._internal() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(connectTimeout: 15000)
      );
      // _dio!.interceptors.add(DioLogInterceptor());
      // _dio!.interceptors.add(ResponseInterceptors());
    }
  }

  factory HttpManager() => _instance;

  Future _handle({required response}) async {
    Response? myResponse;
    try {
      myResponse = response;
    } on DioError catch (e) {
      printWithDebug(e);
    }

    if (myResponse!.data is DioError) {
    }

    return myResponse.data;
  }

  Future get(path, {args}) async {
    return _handle(
        response: await _dio!.get(path, queryParameters: args)
    );
  }

  Future post(path, {args}) async {
    return _handle(
        response: await _dio!.post(path, queryParameters: args)
    );
  }

  Future delete(path, {args}) async {
    return _handle(
        response: await _dio!.delete(path, queryParameters: args)
    );
  }

  Future put(path, {args}) async {
    return _handle(
        response: await _dio!.put(path, queryParameters: args)
    );
  }
}