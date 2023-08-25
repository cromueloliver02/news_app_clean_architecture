import 'package:news_app_clean_architecture/core/failures/failures.dart';

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'Something went wrong unexpectedly',
    super.exception,
    super.stackTrace,
  });

  @override
  String toString() =>
      'Failure: UnexpectedFailure\nException: $exception\nMessage: $message\nException: $exception\nStacktrace: $stackTrace';
}
