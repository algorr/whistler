import 'package:whistler/core/errors/failure.dart';

/// This Dart code snippet is defining a class named `RecordFailure` that extends the `Failure` class.
/// The `RecordFailure` class has a constructor that takes two required parameters: `message` and
/// `statusCode`. These parameters are passed to the constructor of the superclass `Failure` using the
/// `super` keyword.
final class RecordFailure extends Failure {
  const RecordFailure({
    required super.message,
    required super.statusCode,
  });
}
