import 'package:news_app_clean_architecture/core/failures/failures.dart';

class HttpFailure extends Failure {
  final int statusCode;

  const HttpFailure({
    required this.statusCode,
    super.message = 'Something went wrong on your network request',
    super.exception,
    super.stackTrace,
  });

  @override
  String toString() =>
      'Failure: HttpFailure\nStatus Code: $statusCode\nException: $exception\nMessage: $message\nException: $exception\nStacktrace: $stackTrace';
}
