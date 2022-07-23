import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// An utility for safely manipulating a result.
///
/// By using [Result], you are guaranteed that you cannot forget to handle the
/// error state of an asynchronous operation.
///
/// It also expose some utilities to nicely convert an [Result] to a different
/// object. For example, a Flutter Widget may use [when] to convert a [Result]
/// into an error screen, or to show the data.
@freezed
class Result<T> with _$Result<T> {
  const factory Result.data(T value) = _ResultData;
  const factory Result.failure(Failure failure) = _ResultFailure;
}

/// An utility for safely manipulating an empty result.
///
/// By using [EmptyResult], you are guaranteed that you cannot forget to handle the
/// error state of an asynchronous operation.
///
/// It also expose some utilities to nicely convert an [EmptyResult] to a different
/// object. For example, a Flutter Widget may use [when] to convert a [EmptyResult]
/// into an error screen, or to show the data.
@freezed
class EmptyResult with _$EmptyResult {
  const factory EmptyResult.success() = _EmptyResultSuccess;
  const factory EmptyResult.failure(Failure failure) = _EmptyResultFailure;
}

@immutable
class Failure {
  const Failure(this.message);

  final String message;
}
