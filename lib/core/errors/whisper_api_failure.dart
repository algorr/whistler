import 'package:whistler/core/errors/failure.dart';

/// The `WhisperApiFailure` class in Dart represents a failure related to the Whisper API with a message
/// and status code.
class WhisperApiFailure extends Failure {
  const WhisperApiFailure({
    required super.message,
    required super.statusCode,
  });
}
