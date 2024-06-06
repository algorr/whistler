import 'package:whistler/core/errors/failure.dart';

class WhisperApiFailure extends Failure {
  const WhisperApiFailure({required super.message, required super.statusCode});
}
