import 'package:posterr/domain/domain.dart';

class ContentRepositoryMock implements ContentRepository {
  final _cache = <Content>[];

  @override
  Future<Result<List<Content>>> getContents({
    User? user,
    int? page,
    int? itemsLengthPerPage,
  }) async {
    List<Content> list;

    if (user != null) {
      final filteredList = _cache //
          .where((content) => content.author == user)
          .toList();
      list = filteredList;
    } else {
      list = _cache;
    }

    if (itemsLengthPerPage != null && page != null) {
      final maxLength = itemsLengthPerPage * page;
      final startIndex = maxLength - itemsLengthPerPage;
      // Decreasing 1, since we are dealing with index instead of count.
      final endIndex = maxLength - 1;
      list = list.sublist(startIndex, endIndex);
    }

    return Result.data(list);
  }
}
