import 'package:flutter/material.dart';

import 'router.dart';
import 'myhomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '단어공부',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary
        )
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/startPage',
      home: MyHomePage(),
    );
  }
}