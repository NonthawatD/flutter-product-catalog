import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:product_catalog_application/configs/network/endpoint.dart';
import 'package:product_catalog_application/configs/network/network_exception.dart';

export 'endpoint.dart';

class ApiCalling {
  late final Dio _dio;

  ApiCalling({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoint.baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              headers: {'Accept': 'application/json'},
            ),
          ) {
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor());
    }
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final res = await _dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options ?? Options(),
      );
      return res.data;
    } on DioException catch (e) {
      throw NetworkException.fromDio(path, e);
    }
  }
}
