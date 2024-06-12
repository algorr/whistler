import 'package:whistler/core/errors/failure.dart';

/// This Dart code snippet is defining a class named `CacheFailure` that extends the `Failure` class.
/// The `CacheFailure` class has a constructor that takes two required parameters: `message` and
/// `statusCode`.
final class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
  });
}
