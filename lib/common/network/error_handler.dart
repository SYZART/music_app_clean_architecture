// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:openmusic/common/failure.dart';

class ErrorHandler implements Exception {
  late ServerFailure serverFailure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      serverFailure = _handleError(error);
    } else {
      // default error
      serverFailure = DataSource.DEFAULT.getFailure();
    }
  }
}

ServerFailure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ServerFailure(error.response?.statusCode ?? 0,
            error.response?.data["message"] ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  ServerFailure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return const ServerFailure(
            ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return const ServerFailure(
            ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return const ServerFailure(
            ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return const ServerFailure(
            ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return const ServerFailure(
            ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return const ServerFailure(
            ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return const ServerFailure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return const ServerFailure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return const ServerFailure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return const ServerFailure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return const ServerFailure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return const ServerFailure(
            ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return const ServerFailure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return const ServerFailure(
            ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class AppStrings {
  static const strNoRouteFound = "no_route_found";
  static const strAppName = "app_name";

  static const String success = "success";
  // error handler
  static const String strBadRequestError = "bad_request_error";
  static const String strNoContent = "no_content";
  static const String strForbiddenError = "forbidden_error";
  static const String strUnauthorizedError = "unauthorized_error";
  static const String strNotFoundError = "not_found_error";
  static const String strConflictError = "conflict_error";
  static const String strInternalServerError = "internal_server_error";
  static const String strUnknownError = "unknown_error";
  static const String strTimeoutError = "Connetion timeout";
  static const String strDefaultError = "Terjadi Kesalahan";
  static const String strCacheError = "cache_error";
  static const String strNoInternetError = "no_internet_error";
}

class ResponseMessage {
  static const String SUCCESS = AppStrings.success; // success with data
  static const String NO_CONTENT =
      AppStrings.success; // success with no data (no content)
  static const String BAD_REQUEST =
      AppStrings.strBadRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      AppStrings.strUnauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      AppStrings.strForbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      AppStrings.strInternalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      AppStrings.strNotFoundError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.strTimeoutError;
  static const String CANCEL = AppStrings.strDefaultError;
  static const String RECIEVE_TIMEOUT = AppStrings.strTimeoutError;
  static const String SEND_TIMEOUT = AppStrings.strTimeoutError;
  static const String CACHE_ERROR = AppStrings.strCacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.strNoInternetError;
  static const String DEFAULT = AppStrings.strDefaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 200;
  static const int FAILURE = 400;
}
