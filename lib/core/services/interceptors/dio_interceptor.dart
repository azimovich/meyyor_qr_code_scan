import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInterceptor extends Interceptor {
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // PrettyDioLogger orqali requestni log qilish
    _logger.onRequest(options, handler);
    // handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // PrettyDioLogger orqali response'ni log qilish
    _logger.onResponse(response, handler);
    // handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // PrettyDioLogger orqali error'ni log qilish
    _logger.onError(err, handler);
    // handler.next(err);
  }
}
