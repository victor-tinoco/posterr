import 'package:flutter/foundation.dart';
import 'package:posterr/domain/domain.dart';

class AuthRepositoryMock implements AuthRepository {
  @override
  ValueNotifier<User?> get loggedUser {
    final mockedUser = User(username: 'victor-tinoco', joinedAt: DateTime(2020, 05, 13));
    return ValueNotifier(mockedUser);
  }
}
