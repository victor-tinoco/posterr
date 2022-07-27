import 'package:posterr/domain/domain.dart';

/// {@template domain.get_content}
/// An interface for usecases which are used for getting a [Content] list.
///
/// It should be possible to provide a [page], but if `null`  should return the whole list.
/// {@endtemplate}
abstract class GetContent {
  /// {@macro domain.get_content}
  Future<Result<List<Content>>> call({int? page});
}
