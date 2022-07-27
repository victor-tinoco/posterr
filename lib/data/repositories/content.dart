import 'package:posterr/domain/domain.dart';

class ContentRepositoryMock implements ContentRepository {
  final _cache = <Content>[
    Content.quotePost(
      author: User(username: 'victor-tinoco', joinedAt: DateTime(2020, 3, 2)),
      message: 'I totally agree.',
      post: Post(
        author: User(username: 'alesandro123', joinedAt: DateTime(2020, 3, 17)),
        message: "I really didn't like it. Backing to the neighbor blue social media.",
        postedAt: DateTime(2022, 7, 27),
      ),
      postedAt: DateTime(2022, 7, 27),
    ),
    Content.post(
      author: User(username: 'alesandro123', joinedAt: DateTime(2020, 3, 17)),
      message: "I really didn't like it. Backing to the neighbor blue social media.",
      postedAt: DateTime(2022, 7, 27),
    ),
    Content.repost(
      author: User(username: 'victor-tinoco', joinedAt: DateTime(2020, 3, 2)),
      originalPost: Post(
        author: User(username: 'jordanp2', joinedAt: DateTime(2020, 7, 3)),
        message: "Just sharing some content here. Amazing new social media! Congrats Posterr's team!",
        postedAt: DateTime(2022, 7, 27),
      ),
      postedAt: DateTime(2022, 7, 27),
    ),
    Content.post(
      author: User(username: 'alanis-c', joinedAt: DateTime(2020, 3, 17)),
      message: "It's really good. Damn twitter!",
      postedAt: DateTime(2022, 7, 27),
    ),
    Content.post(
      author: User(username: 'jordanp2', joinedAt: DateTime(2020, 7, 3)),
      message: "Just sharing some content here. Amazing new social media! Congrats Posterr's team!",
      postedAt: DateTime(2022, 7, 27),
    ),
  ];

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

  @override
  Future<EmptyResult> shareContent(Content content) async {
    _cache.add(content);
    return const EmptyResult.success();
  }
}
