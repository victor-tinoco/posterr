import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// A regex expression which only matches alphanumeric characters.
///
/// It can be used by calling [onlyAlphanumericCharactersRegex.hasMatch] into a
/// source string.
final onlyAlphanumericCharactersRegex = RegExp(r'^[a-zA-Z0-9]+$');

@freezed
class User with _$User {
  @Assert('username.isNotEmpty', 'Username cannot be empty.')
  @Assert('username.length <= 14', 'Username cannot be greater than 14 characters.')
  @Assert('onlyAlphanumericCharactersRegex.hasMatch(username)', 'Username only allows alphanumeric characters.')
  const factory User({
    required String username,
    required DateTime joinedAt,
  }) = _User;
}
