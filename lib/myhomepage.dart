import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _key = new GlobalKey<ScaffoldState>();
  final _googleSignIn = new GoogleSignIn();

  GoogleSignInAccount _currentUser;
  
  double _cardWidth = 850;      // 넓이
  double _cardHeight = 400;     // 높이
  double _cardTextSize = 85;    // 글꼴 크기

  double _everyButtonHeight = 45;  // 버튼 간격

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
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80.w)
          )
        ),
        onPressed: () {
          print('한글보고 영어 쓰기');
        },
        elevation: 10,
        child: Text('한글보고 영어 쓰기' , style: TextStyle(fontSize: _cardTextSize.sp)),
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
          )
        ),
        onPressed: () {
          print('영어보고 한글 쓰기');
        },
        elevation: 10,
        child: Text('영어보고 한글 쓰기' , style: TextStyle(fontSize: _cardTextSize.sp)),
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
          )
        ),
        onPressed: () {
          print('단어장');
        },
        elevation: 10,
        child: Text('단어장' , style: TextStyle(fontSize: _cardTextSize.sp)),
      ),
    );
  }

  // PageDrawer
  _pageDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
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
              _handleSignIn();
              _googleSignIn.onCurrentUserChanged.listen((event) {
                setState(() {
                  print('$event');
                  _currentUser = event;
                });
              });
            } : null,
          ),
          ListTile(
            title: Text('캘린더'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('설정'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {

            },
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      key: _key,
      drawer: _pageDrawer(),
      backgroundColor: Colors.green,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 50.w),
              child: IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  _key.currentState.openDrawer();
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
                  _cardToEngTap(),
                  SizedBox(
                    height: _everyButtonHeight.h,
                  ),
                  _cardToKorTap(),
                  SizedBox(
                    height: _everyButtonHeight.h,
                  ),
                  _vocabularyNote()
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
