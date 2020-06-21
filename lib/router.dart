import 'package:english_word_memorize/wordpage/english_word.dart';
import 'package:flutter/material.dart';

import 'homepage/calendarpage.dart';
import 'homepage/settingpage.dart';
import 'startPage.dart';

final routes = {
  '/startPage' : (context) => StartPage(),                  // 시작 페이지 (initroute)

  '/englishWord': (context) => EnglishWordToKorean(),

  '/calendarPage': (context) => CalendarPage(),    // 캘린더 페이지
  '/settingPage': (context) => SettingPage(),      // 설정 페이지
};

// MaterialApp
final onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
        return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};