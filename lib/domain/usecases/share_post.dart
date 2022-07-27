import 'package:posterr/domain/domain.dart';

/// The maximum length in which a [Post]'s message can be written.
const maxPostMessageLength = 777;

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
      final userContentPostedToday = userContent.where((content) => content.postedAt.isAtTheSameDateOf(DateTime.now()));

      if (userContentPostedToday.length >= 5) {
        return EmptyResult.failure(DailyPostsLimitExceededFailure());
      }
    }

    if (message.length > maxPostMessageLength) {
      return EmptyResult.failure(TooMuchLongMessageFailure());
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

class TooMuchLongMessageFailure implements Failure {
  @override
  String get message => 'Posts can have a maximum of $maxPostMessageLength characters.';
}

// TODO(victor-tinoco): Place this extension in a proper path and reuse.
extension on DateTime {
  /// Whether or not this date is the same of an [other] one.
  ///
  /// It won't consider time when comparing.
  bool isAtTheSameDateOf(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
