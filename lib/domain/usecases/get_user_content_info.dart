import 'package:posterr/domain/domain.dart';

/// {@template domain.get_user_content_info}
/// Gets the content info from the given [user].
///
/// See more:
/// * [UserContentInfo], an object that deal with information about the content
/// from a given user.
/// {@endtemplate}
class GetUserContentInfo {
  /// {@macro domain.get_user_content_info}
  GetUserContentInfo({required this.contentRepository});

  final ContentRepository contentRepository;

  /// {@macro domain.get_user_content_info}
  Future<Result<UserContentInfo>> call(User user) => contentRepository.getContentInfo(user);
}
