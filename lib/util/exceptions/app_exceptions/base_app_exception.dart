abstract class AppException implements Exception {
  final String errorMsg;

  AppException(this.errorMsg);
  
  @override
  String toString() => errorMsg;
}