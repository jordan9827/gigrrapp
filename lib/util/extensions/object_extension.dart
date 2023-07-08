import 'dart:io';
import '../../others/constants.dart';
import '../exceptions/failures/failure.dart';

enum NetworkStatus {
  SocketStatus,
  CommonStatus,
}

extension ObjectExtension on Object {
  Failure handleException() {
    if (this is Exception) {
      if (this is SocketException) {
        return Failure(
          NetworkStatus.SocketStatus.index,
          "commonNetworkMsg111",
        );
        // return Failure(NetworkStatus.SocketStatus.index,
        //     "Unable to connect with server, please check your internet connection and try again");
      }
      return Failure(NetworkStatus.CommonStatus.index,
          "Unknown error occurred on the server");
    }
    return Failure(NetworkStatus.CommonStatus.index,
        "Unknown error occurred on the server");
  }
}
