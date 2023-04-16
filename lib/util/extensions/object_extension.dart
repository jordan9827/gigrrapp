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
          commonNetworkMsg,
        );
        // return Failure(NetworkStatus.SocketStatus.index,
        //     "Unable to connect with server, please check your internet connection and try again");
      }
      return Failure(NetworkStatus.CommonStatus.index, commonNetworkMsg);
    }
    return Failure(NetworkStatus.CommonStatus.index, commonNetworkMsg);
  }
}
