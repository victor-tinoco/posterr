import 'package:posterr/domain/domain.dart';

/// {@template domain.share_post}
/// Shares a given text-based content.
///
/// Returns a failure when the user has reached out its daily post limit.
///
/// See more:
/// * [Post], an user-generated text-based content.
/// {@endtemplate}
class SharePost {
  SharePost({
    required this.getLoggedUserContent,
    required this.contentRepository,
    required this.authRepository,
  });

  final GetLoggedUserContent getLoggedUserContent;
  final AuthRepository authRepository;
  final ContentRepository contentRepository;

  /// {@macro domain.share_post}
  Future<EmptyResult> call(String message) async {
    final userContentResult = await getLoggedUserContent();

    // TODO(victor-tinoco): I don't think this logic should be in the front-side,
    // since would be easy to just do a reverse engineering and bypass this logic
    // by calling the backend directly, for example.
    if (userContentResult is EmptyResultFailure) {
      final failure = Failure((userContentResult as ResultFailure).failure.message);
      return EmptyResult.failure(failure);
    } else {
      final userContent = userContentResult.whenOrNull(data: (list) => list) ?? [];
      // TODO(victor-tinoco): Use clock package in order to be possible to test this date.
      final userContentPostedToday = userContent.where((content) => content.postedAt == DateTime.now());

      if (userContentPostedToday.length >= 4) {
        return EmptyResult.failure(DailyPostsLimitExceededFailure());
      }
    }

    // TODO(victor-tinoco): Use clock package in order to be possible to test this date.
    final post = Post(
      author: authRepository.loggedUser.value!,
      message: message,
      postedAt: DateTime.now(),
    );

    return contentRepository.shareContent(post);
  }
}

class DailyPostsLimitExceededFailure implements Failure {
  @override
  String get message => 'You have reached out your daily post limit. Try again tomorrow.';
}
