import 'package:flutter/material.dart';

import 'package:english_word_memorize/router.dart';
import 'homepage/myhomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '단어공부',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      home: MyHomePage(),
    );
  }
}