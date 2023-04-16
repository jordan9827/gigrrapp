import '../enums/status_code_type.dart';

const List<int> statusCodes = [401, 400, 500, 408, 404];

extension StatusCodeTypeExtension on int {
  StatusCodeType getStatusCode() {
    if (this == statusCodes[0]) {
      return StatusCodeType.UNAUTHORIZED;
    } else if (this == statusCodes[1]) {
      return StatusCodeType.BAD_REQUEST;
    } else if (this == statusCodes[2]) {
      return StatusCodeType.SERVER_ERROR;
    } else if (this == statusCodes[3]) {
      return StatusCodeType.CLIENT_TIMEOUT;
    } else if (this == statusCodes[4]) {
      return StatusCodeType.NOT_FOUND;
    }
    return StatusCodeType.UNDEFINED;
  }
}
