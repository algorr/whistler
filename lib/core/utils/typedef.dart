import 'package:dartz/dartz.dart';
import 'package:whistler/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
