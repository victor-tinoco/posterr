import 'package:posterr/domain/entities/entities.dart';

abstract class ContentRepository {
  Future<Result<List<Content>>> getContents({
    User? user,
    int? page,
    int? itemsLengthPerPage,
  });

  Future<EmptyResult> shareContent(Content content);

  Future<Result<UserContentInfo>> getContentInfo(User user);
}
