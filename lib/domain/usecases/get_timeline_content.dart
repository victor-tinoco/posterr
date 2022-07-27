import 'package:posterr/domain/domain.dart';

/// {@template domain.get_timeline_content}
/// Gets all content from this user's timeline.
///
/// It is possible to provide a [page], but if `null` returns the whole list.
/// {@endtemplate}
class GetTimelineContent implements GetContent {
  GetTimelineContent({required this.contentRepository});

  final ContentRepository contentRepository;

  /// {@macro domain.get_timeline_content}
  @override
  Future<Result<List<Content>>> call({int? page}) {
    const itemsLengthPerPage = 20;

    return contentRepository.getContents(
      page: page,
      itemsLengthPerPage: page != null ? itemsLengthPerPage : null,
    );
  }
}
