import 'dart:convert';
import 'dart:io';
import 'package:pub_semver/pub_semver.dart';

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

  String handleFailureMessage() {
    print("error message---->$this");
    Map<String, dynamic> error = json.decode(this.toString());

    if (error.containsKey('message')) {
      return error["message"];
    } else if (error.containsKey('field')) {
      return error["field"];
    } else if (error.containsKey('error')) {
      if (error['error'] is Map<String, dynamic>) {
        return error['error']["message"];
      } else if (error['error'] is List<Map<String, dynamic>>) {
        return error['error'][0]["message"];
      } else {
        return error["No Message from server."];
      }
    } else {
      return error["No Message from server."];
    }
  }
}
