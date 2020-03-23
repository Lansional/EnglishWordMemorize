import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 350,
                height: 150,
                child: InkWell(
                  onTap: () {

                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        '한글보고 영어 쓰기',
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                    ),
                    elevation: 10,
                  ),
                )
              ),
            SizedBox(
              height: 15,
            ),
            Container(
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
                        fontSize: 30
                      ),
                    ),
                  ),
                  elevation: 10,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
