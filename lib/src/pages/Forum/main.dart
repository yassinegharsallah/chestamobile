import 'package:flutter/material.dart';
import 'package:flutter_login/src/pages/Forum/view/presentation/themes.dart';

import '../../../home_page.dart';

void main() => runApp(Leaf());

class Leaf extends StatelessWidget {
  const Leaf({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        brightness: Brightness.light,
        textTheme: TextTheme(
          title: TextThemes.title,
          subtitle: TextThemes.subtitle,
          body1: TextThemes.body1,
        ),
      ),
      home: HomePage(),
    );
  }
}
