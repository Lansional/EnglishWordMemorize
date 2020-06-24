import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'router.dart';
import 'myhomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,
        primaryColorDark: Colors.black,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        )
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: '단어공부장',
          locale: Locale('ko-KR'),
          theme: theme,
          onGenerateRoute: onGenerateRoute, 
          initialRoute: '/startPage',
          home: MyHomePage(),
        );
      },
    );
  }
}