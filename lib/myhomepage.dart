import 'package:english_word_memorize/homepage/calendarpage.dart';
import 'package:english_word_memorize/homepage/settingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'homepage/pagecontrol.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bottomNaviagtionBar index
  int _bottomIndex = 0;

  // bottomNaviagtionBar item
  final _bottomItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('홈'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text('춣석 캘린더')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('설정')
    )
  ];

  final _pageBody = <Widget>[
    PageControl(),
    CalendarPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);           // width : 1080px, height : 1920px

    return Scaffold(
      backgroundColor: Colors.green,
      body: _pageBody[_bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        items: _bottomItems,
        onTap: (index) {
          setState(() {
            this._bottomIndex = index;
          });
        },
      ),
    );
  }
}
