import 'package:flutter/material.dart';
import 'package:wasteagram/screens/entry_lists.dart';
import 'package:wasteagram/screens/new_post.dart';
import 'package:wasteagram/themeData.dart';

class App extends StatelessWidget {
  final String title;
  const App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: this.title,
        theme: AppTheme().buildThemeData(),
        // home: Scaffold(body: NewPosts()),
        home: Scaffold(
          body: EntryLists(),
        ));
  }
}
