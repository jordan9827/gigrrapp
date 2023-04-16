import 'package:square_demo_architecture/util/extensions/status_code_extension.dart';

import '../../enums/status_code_type.dart';

abstract class NetworkException implements Exception {
  final int _statusCode;
  late final String _errorMsg;
  late final StatusCodeType _statusCodeType;

  int get statusCode => _statusCode;
  String get errorMsg => _errorMsg;
  StatusCodeType get statusCodeType => _statusCodeType;

  NetworkException({required int statusCode, String? errorMsg})
      : _statusCode = statusCode {
    _statusCodeType = _statusCode.getStatusCode();
    _errorMsg = errorMsg ?? _getErrorMsg();
  }

  String _getErrorMsg() {
    if (statusCodeType == StatusCodeType.UNAUTHORIZED) {
      return "Unauthorized user";
    } else if (_statusCode == StatusCodeType.SERVER_ERROR) {
      return "Unknown error occurred on the server";
    } else if (_statusCode == StatusCodeType.NOT_FOUND) {
      return "Specified address not found";
    } else if (_statusCode == StatusCodeType.BAD_REQUEST) {
      return "The request could not be understood by the server due to malformed syntax";
    } else if (_statusCode == StatusCodeType.CLIENT_TIMEOUT) {
      return "Unable to connect to the server, check internet connection";
    }
    return "Unknown error occurred with status code $_statusCode";
  }

  @override
  String toString() => errorMsg;
}
