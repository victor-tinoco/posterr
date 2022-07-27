import 'package:posterr/domain/domain.dart';

/// {@template domain.get_logged_user_content}
/// Gets the logged user's content based on the current user into the [authRepository].
///
/// It is possible to provide a [page], but if `null` returns the whole list.
/// {@endtemplate}
class GetLoggedUserContent implements GetContent {
  GetLoggedUserContent({
    required this.contentRepository,
    required this.authRepository,
  });

  final AuthRepository authRepository;
  final ContentRepository contentRepository;

  /// {@macro domain.get_logged_user_content}
  @override
  Future<Result<List<Content>>> call({int? page}) {
    const itemsLengthPerPage = 10;

    return contentRepository.getContents(
      user: authRepository.loggedUser.value,
      page: page,
      itemsLengthPerPage: page != null ? itemsLengthPerPage : null,
    );
  }
}
