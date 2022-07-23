import 'package:posterr/domain/entities/user.dart';

abstract class ContentRepository {
  Future<void> getContents({User? user});
}
