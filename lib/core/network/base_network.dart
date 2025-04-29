import 'package:dio/dio.dart';
import 'package:news_circle/utils/app_logger.dart';
import 'package:news_circle/utils/constants.dart';
import 'package:news_circle/utils/enums.dart';
import 'package:news_circle/utils/errors/exception.dart';

class BaseNetwork {
  final Dio _dio;

  BaseNetwork(this._dio);

  Future<T> sendRequest<T>({
    required NetworkRequestMethod method,
    required String endpoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    late Response response;
    try {
      switch (method) {
        case NetworkRequestMethod.get:
          response = await _dio.get(
            '${StringConstants.baseNewsApiUrl}/$endpoint',
            queryParameters: queryParameters,
            options: Options(headers: headers)
          );
        case NetworkRequestMethod.post:
          response = await _dio.post(
            '${StringConstants.baseNewsApiUrl}/$endpoint',
            queryParameters: queryParameters,
          );
        case NetworkRequestMethod.put:
          response = await _dio.put(
            '${StringConstants.baseNewsApiUrl}/$endpoint',
            queryParameters: queryParameters,
          );
        case NetworkRequestMethod.patch:
          response = await _dio.patch(
            '${StringConstants.baseNewsApiUrl}/$endpoint',
            queryParameters: queryParameters,
          );
        case NetworkRequestMethod.delete:
          response = await _dio.delete(
            '${StringConstants.baseNewsApiUrl}/$endpoint',
            queryParameters: queryParameters,
          );
      }

      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        return fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(
            "${StringConstants.unauthorized}: ${response.statusCode}");
      } else if (response.statusCode == 403) {
        throw ForbiddenException(
            "${StringConstants.forbidden}: ${response.statusCode}");
      } else if (response.statusCode == 404) {
        throw NotFoundException(
            "${StringConstants.notFound}: ${response.statusCode}");
      } else if (response.statusCode! >= 500) {
        throw ServerErrorException(
            "${StringConstants.serverError}: ${response.statusCode}");
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: '${response.statusMessage}',
        );
      }
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw ConnectionTimeOutException(
              StringConstants.connectionTimeOutMessage);
        case DioExceptionType.sendTimeout:
          throw SendTimeoutException(StringConstants.sendTimeOutMessage);
        case DioExceptionType.receiveTimeout:
          throw ReceiveTimeoutException(StringConstants.receiveTimeOutMessage);
        case DioExceptionType.badCertificate:
          throw BadCertificateException(StringConstants.badCertificateMessage);
        case DioExceptionType.badResponse:
          throw BadResponseException(StringConstants.badResponseMessage);
        case DioExceptionType.cancel:
          throw CancelException(StringConstants.cancelRequestMessage);
        case DioExceptionType.connectionError:
          throw ConnectionErrorException(
              StringConstants.connectionErrorMessage);
        case DioExceptionType.unknown:
          throw UnknownErrorException(StringConstants.unknownErrorMessage);
      }
    } catch (error) {
      AppLogger.e('[Exception]: $error');
      rethrow;
    }
  }
}
