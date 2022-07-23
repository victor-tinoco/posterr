import 'package:flutter/material.dart';
import 'package:posterr/ui/pages/home/home_page.dart';
import 'package:posterr/ui/pages/profile/profile_page.dart';

void main() {
  runApp(const PosterrApp());
}

class PosterrApp extends StatelessWidget {
  const PosterrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posterr',
      theme: ThemeData(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
      },
    );
  }
}
