import 'package:dio/dio.dart';

class Failure {
  final String message;
  Failure({required this.message});
}

class NetworkException extends Failure implements Exception {
  int statusCode;
  DioExceptionType? dioType;
  String endpoint;
  dynamic data;

  NetworkException({
    this.data,
    this.statusCode = 0,
    super.message = "",
    this.dioType,
    this.endpoint = "",
  });

  static NetworkException fromDio(String endpoint, DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      final code = e.response?.statusCode;
      final serverMsg = _extractServerMessage(e.response?.data);
      final msg = switch (code) {
        400 => serverMsg ?? 'Bad request',
        401 => serverMsg ?? 'Unauthorized',
        403 => serverMsg ?? 'Forbidden',
        404 => serverMsg ?? 'Not found',
        408 => serverMsg ?? 'Request timeout',
        409 => serverMsg ?? 'Conflict',
        422 => serverMsg ?? 'Unprocessable entity',
        429 => serverMsg ?? 'Too many requests',
        500 => serverMsg ?? 'Server error',
        502 => serverMsg ?? 'Bad gateway',
        503 => serverMsg ?? 'Service unavailable',
        504 => serverMsg ?? 'Gateway timeout',
        _ => serverMsg ?? 'HTTP error ($code)',
      };
      return NetworkException(
        message: msg,
        statusCode: code ?? 0,
        dioType: e.type,
        endpoint: endpoint,
        data: e.response?.data,
      );
    }

    final msg = switch (e.type) {
      DioExceptionType.connectionTimeout =>
        'การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง',
      DioExceptionType.sendTimeout =>
        'การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง',
      DioExceptionType.receiveTimeout =>
        'การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง',
      DioExceptionType.cancel => 'ยกเลิกการเชื่อมต่อ',
      DioExceptionType.badCertificate => 'ใบรับรองความปลอดภัยไม่ถูกต้อง',
      DioExceptionType.connectionError => 'ไม่มีการเชื่อมต่ออินเทอร์เน็ต',
      _ => 'เกิดข้อผิดพลาดในการเชื่อมต่อ',
    };

    return NetworkException(
      message: msg,
      statusCode: e.response?.statusCode ?? 0,
      dioType: e.type,
      endpoint: endpoint,
      data: e.response?.data,
    );
  }

  static bool isMap(dynamic data) {
    return data is Map<String, dynamic>;
  }

  static bool containsKey(Map data, String key) {
    return data.containsKey(key);
  }

  static String? _extractServerMessage(dynamic data) {
    try {
      if (isMap(data)) {
        if (containsKey(data, "status") &&
            containsKey(data["status"], "description")) {
          return data["status"]["description"].toString();
        }
        if (data['message'] is String) return data['message'] as String;
        if (data['error'] is Map && data['error']['message'] is String) {
          return data['error']['message'] as String;
        }
      }
    } catch (_) {}
    return null;
  }
}
