import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  double _cardWidth = 850;
  double _cardHeight = 400;
  double _cardTextSize = 85;

  double _everyButtonHeight = 45;

  DateTime _backbuttonpressedTime;

  var _cardSide = BorderSide(color: Colors.white, width: 4);

  List _documentsName = [
    '수능',
    'Unit 12',
    'Unit 13',
  ];

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // check internet connective
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Toast.show('인터넷 연결이 되어 있지 않습니다.', context);
        Future.delayed(Duration(seconds: 2), () {
          exit(0);
        });
      }
      // } else {
      //   _accountLoginErrorClick();
      // }
    });
  }

  // Write in English for Korean report.
  _cardToEngTap() {
    return Container(
        width: _cardWidth.w,
        height: _cardHeight.h,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80.w)),
              side: _cardSide),
          onPressed: () {
            // print('한글보고 영어 쓰기');
            Navigator.pushNamed(context, '/validator',
                arguments: {'what': 'korean'});
          },
          elevation: 10,
          child: Text('한글보고 영어 쓰기',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _cardTextSize.sp)),
        ));
  }

  // Write in Korean for English report
  _cardToKorTap() {
    return Container(
        width: _cardWidth.w,
        height: _cardHeight.h,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80.w)),
              side: _cardSide),
          onPressed: () {
            Navigator.pushNamed(context, '/validator',
                arguments: {'what': 'english'});
          },
          elevation: 10,
          child:
              Text('영어보고 뜻 쓰기', style: TextStyle(fontSize: _cardTextSize.sp)),
        ));
  }

  _vocabularyNote() {
    return Container(
      width: (_cardWidth / 2 - 12).w,
      height: (_cardHeight - 12).h,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(80.w)),
            side: _cardSide),
        onPressed: () {
          Navigator.pushNamed(context, '/wordUnitChoose');
        },
        elevation: 10,
        child: Text('단어장', style: TextStyle(fontSize: _cardTextSize.sp)),
      ),
    );
  }

  _wrongWordNote() {
    return Container(
      width: (_cardWidth / 2 - 12).w,
      height: (_cardHeight - 12).h,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(80.w)),
            side: _cardSide),
        onPressed: () {},
        elevation: 10,
        child: Text('오답   단어장',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: _cardTextSize.sp)),
      ),
    );
  }

  _child() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cardToEngTap(),
          SizedBox(
            height: _everyButtonHeight.h,
          ),
          _cardToKorTap(),
          SizedBox(
            height: _everyButtonHeight.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _vocabularyNote(),
              SizedBox(
                width: 30.w,
              ),
              _wrongWordNote()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green
            : null,
        floatingActionButton: Container(
          child: FloatingActionButton(
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () => _showModalBottomSheet()),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 4)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            color: Theme.of(context).primaryColor,
            child: Container(
              height: 150.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.lightbulb_outline, color: Colors.white),
                      onPressed: () => _changeBrightness())
                ],
              ),
            )),
        key: _scaffoldKey,
        // drawer: _pageDrawer(),
        body: WillPopScope(child: _child(), onWillPop: _onWillPop));
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SizedBox(
            height: 830.h,
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.h,
                  width: ScreenUtil.screenWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    border: Theme.of(context).brightness == Brightness.dark
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  // padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Center(
                      child: Text('추가할 단어의 단원을 선택하세요',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25))),
                ),
                Container(
                  height: 550.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Theme.of(context).brightness == Brightness.dark
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: ListView.builder(
                      itemCount: _documentsName.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${_documentsName[index]}'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/addWord',
                                arguments: '${_documentsName[index]}');
                          },
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  // double back to close
  Future<bool> _onWillPop() async {
    if (_backbuttonpressedTime == null ||
        DateTime.now().difference(_backbuttonpressedTime) >
            Duration(seconds: 2)) {
      _backbuttonpressedTime = DateTime.now();
      Toast.show('두번 눌러 앱 종료하기!', context);
    } else {
      _backbuttonpressedTime = DateTime.now();
      // exit
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }
}
