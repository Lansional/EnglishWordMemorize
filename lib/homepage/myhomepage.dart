import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  double _cardWidth = 850;      // 넓이
  double _cardHeight = 400;     // 높이
  double _cardTextSize = 90;

  // Homepage Drawer
  _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

        ],
      ),
    );
  }

  // Write in English for Korean report.
  _cardToEngTap() {
    return Container(
      width: _cardWidth.w,
      height: _cardHeight.h,
      margin: EdgeInsets.only(top: 50),
      child: InkWell(
        onTap: () {
          print('한글보고 영어 쓰기');
        },
        child: Card(
          child: Center(
            child: Text(
              '한글보고 영어 쓰기',
              style: TextStyle(
                fontSize: _cardTextSize.sp
              ),
            ),
          ),
          elevation: 10,
        ),
      )
    );
  }

  // Write in Korean for English report
  _cardToKorTap() {
    return Container(
      width: _cardWidth.w,
      height: _cardHeight.h,
      child: InkWell(
        onTap: () {
          print('영어보고 한글 쓰기');
        },
        child: Card(
          child: Center(
            child: Text(
              '영어보고 한글 쓰기',
              style: TextStyle(
                fontSize: _cardTextSize.sp
              ),
            ),
          ),
          elevation: 10,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);           // width : 1080px, height : 1920px

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.green,
      drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.menu), 
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              }
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _cardToEngTap(),
                SizedBox(
                  height: 60.h,
                ),
                _cardToKorTap()
              ],
            ),
          ),
        ],
      )
    );
  }
}
