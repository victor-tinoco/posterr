import 'package:posterr/domain/entities/content.dart';
import 'package:posterr/domain/entities/result.dart';
import 'package:posterr/domain/repositories/content.dart';

/// {@template domain.get_timeline_content}
/// Gets all content from this user's timeline.
///
/// It is possible to provide a [page], but if `null` returns the whole list.
/// {@endtemplate}
class GetTimelineContent {
  GetTimelineContent({required this.contentRepository});

  final ContentRepository contentRepository;

  /// {@macro domain.get_timeline_content}
  Future<Result<List<Content>>> call({int? page}) {
    const itemsLengthPerPage = 20;

    return contentRepository.getContents(
      page: page,
      itemsLengthPerPage: page != null ? itemsLengthPerPage : null,
    );
  }
}
