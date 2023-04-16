import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int errorCode;
  final String errorMsg;

  const Failure(this.errorCode, this.errorMsg);

  @override
  List<Object?> get props => [errorCode, errorMsg];
}
