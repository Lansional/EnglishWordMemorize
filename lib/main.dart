import 'package:flutter/material.dart';

import 'router.dart';
import 'myhomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '단어공부장',
      locale: Locale('ko-KR'),
      // theme: theme,
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/startPage',
      home: MyHomePage(),
    );
  }
}
