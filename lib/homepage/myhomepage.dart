import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

        ],
      ),
    );
  }

  _cardToEngTap() {
    return Container(
      width: 350,
      height: 150,
      margin: EdgeInsets.only(top: 50),
      child: InkWell(
        onTap: () {

        },
        child: Card(
          child: Center(
            child: Text(
              '한글보고 영어 쓰기',
              style: TextStyle(
                fontSize: 35
              ),
            ),
          ),
          elevation: 10,
        ),
      )
    );
  }

  _cardToKorTap() {
    return Container(
      width: 350,
      height: 150,
      child: InkWell(
        onTap: () {

        },
        child: Card(
          child: Center(
            child: Text(
              '영어보고 한글 쓰기',
              style: TextStyle(
                fontSize: 35
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
                  height: 20,
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
