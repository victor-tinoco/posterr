import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  @Assert('username.length > 0', 'Username cannot be empty.')
  @Assert('username.length <= 14', 'Username cannot be greater than 14 characters.')
  const factory User({
    required String username,
    required DateTime joinedAt,
  }) = _User;
}
