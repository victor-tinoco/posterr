import 'package:posterr/domain/domain.dart';

class ShareContent {
  ShareContent({
    required this.getLoggedUserContent,
    required this.contentRepository,
    required this.authRepository,
  });

  final GetLoggedUserContent getLoggedUserContent;
  final AuthRepository authRepository;
  final ContentRepository contentRepository;

  Future<EmptyResult> call(Content content) async {
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

    if (content.author != authRepository.loggedUser.value) {
      return EmptyResult.failure(UnauthorizedPostAuthorFailure());
    }

    return contentRepository.shareContent(content);
  }
}

class DailyPostsLimitExceededFailure implements Failure {
  @override
  String get message => 'You have reached out your daily post limit. Try again tomorrow.';
}

class UnauthorizedPostAuthorFailure implements Failure {
  @override
  String get message => 'It is not possible to share a content with an author other than you.';
}
