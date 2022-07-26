import 'package:flutter/foundation.dart';
import 'package:posterr/domain/entities/entities.dart';

abstract class AuthRepository {
  ValueNotifier<User?> get loggedUser;
}
