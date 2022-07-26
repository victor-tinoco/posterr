import 'package:posterr/domain/entities/entities.dart';

abstract class ContentRepository {
  Future<Result<List<Content>>> getContents({
    User? user,
    int page,
    int? itemsLengthPerPage,
  });
}
