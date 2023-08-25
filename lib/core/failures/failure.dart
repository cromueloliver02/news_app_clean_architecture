import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final Object exception;
  final String message;
  final StackTrace? stackTrace;

  const Failure({
    this.exception = '',
    this.message = '',
    this.stackTrace,
  });

  @override
  List<Object> get props => [exception, message];
}
