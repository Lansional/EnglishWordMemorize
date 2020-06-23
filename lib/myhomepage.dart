import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _googleSignIn = new GoogleSignIn();

  GoogleSignInAccount _currentUser;
  
  double _cardWidth = 850;
  double _cardHeight = 400;
  double _cardTextSize = 85;

  double _everyButtonHeight = 45;

  DateTime _backbuttonpressedTime;

  var _cardSide = BorderSide(
    color: Colors.white,
    width: 4
  );

  @override
  void initState() { 
    super.initState();
    
    _accountLoginErrorClick();
  }

  // google account login
  _accountLoginErrorClick() {
    _handleSignIn();
    _googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _currentUser = event;
      });
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // Write in English for Korean report.
  _cardToEngTap() {
    return Container(
      width: _cardWidth.w,
      height: _cardHeight.h,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80.w)
          ),
          side: _cardSide
        ),
        onPressed: () {
          print('한글보고 영어 쓰기');
        },
        elevation: 10,
        child: Text('한글보고 영어 쓰기' , textAlign: TextAlign.center, style: TextStyle(fontSize: _cardTextSize.sp)),
      )
    );
  }

  // Write in Korean for English report
  _cardToKorTap() {
    return Container(
      width: _cardWidth.w,
      height: _cardHeight.h,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80.w)
          ),
          side: _cardSide
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/englishMeaning');
        },
        elevation: 10,
        child: Text('영어보고 뜻 쓰기' , style: TextStyle(fontSize: _cardTextSize.sp)),
      )
    );
  }

  _vocabularyNote() {
    return Container(
      width: _cardWidth.w,
      height: _cardHeight.h,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80.w)
          ),
          side: _cardSide
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/englishWord');
        },
        elevation: 10,
        child: Text('단어장' , style: TextStyle(fontSize: _cardTextSize.sp)),
      ),
    );
  }

  // PageDrawer
  _pageDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.pinimg.com/originals/2d/6b/9d/2d6b9d7145b42697d47c4fc11e7fa2ca.jpg'),
                fit: BoxFit.cover
              )
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: _currentUser == null ? NetworkImage('https://simpleicon.com/wp-content/uploads/account.png') : NetworkImage('${_currentUser.photoUrl}'),
            ),
            accountName: _currentUser == null ? Text('') : Text('${_currentUser.displayName}'),
            accountEmail: _currentUser == null ? Text('로그인') : Text('${_currentUser.email}'),
            onDetailsPressed: _currentUser == null ? () {
              _accountLoginErrorClick();
            } : null,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('캘린더'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calendarPage');
                  },
                ),
              ],
            )
          ),
          Divider(),
          ButtonBar(
            buttonPadding: EdgeInsets.zero,
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('설정'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settingPage');
                }
              ),
              FlatButton(
                onPressed: () {
                  _googleSignIn.disconnect();
                },
                child: Text('로그아웃'),
                textColor: Colors.red,
              )
            ],
          )
        ],
      )
    );
  }

  _stackChild() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil.screenHeightDp - 1850.h),        // any device height
            child: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              }
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _vocabularyNote(),
                SizedBox(
                  height: _everyButtonHeight.h,
                ),
                _cardToKorTap(),  
                SizedBox(
                  height: _everyButtonHeight.h,
                ),
                _cardToEngTap(),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: _pageDrawer(),
      backgroundColor: Colors.green,
      body: WillPopScope(
        child: _stackChild(), 
        onWillPop: _onWillPop
      )
    );
  }

  // double back to close
  Future<bool> _onWillPop() async {
    if (_backbuttonpressedTime == null || DateTime.now().difference(_backbuttonpressedTime) > Duration(seconds: 2)){
      _backbuttonpressedTime = DateTime.now();
      Toast.show('두번 눌러 앱 종료하기!', context);
    } else {
      _backbuttonpressedTime = DateTime.now();
      // exit
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
