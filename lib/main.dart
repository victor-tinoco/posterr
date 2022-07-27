import 'package:flutter/material.dart';
import 'package:posterr/data/data.dart';
import 'package:posterr/domain/domain.dart';
import 'package:posterr/ui/ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PosterrApp());
}

class PosterrApp extends StatefulWidget {
  const PosterrApp({Key? key}) : super(key: key);

  @override
  State<PosterrApp> createState() => _PosterrAppState();
}

class _PosterrAppState extends State<PosterrApp> {
  final AuthRepository authRepository = AuthRepositoryMock();
  final ContentRepository contentRepository = ContentRepositoryMock();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: authRepository),
        Provider.value(value: contentRepository),
        Provider(create: (context) => GetTimelineContent(contentRepository: contentRepository)),
        Provider(create: (context) => GetLoggedUserContent(contentRepository: contentRepository, authRepository: authRepository)),
        Provider(
          create: (context) {
            return SharePost(
              getLoggedUserContent: context.read(),
              contentRepository: contentRepository,
              authRepository: authRepository,
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Posterr',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
        },
      ),
    );
  }
}
