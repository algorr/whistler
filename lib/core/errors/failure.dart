import 'package:equatable/equatable.dart';

/// The `Failure` class in Dart represents a generic failure with a message and status code.
abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}
