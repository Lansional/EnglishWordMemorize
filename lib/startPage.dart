import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final double size = 420;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          height: size.h,
          width: size.w,
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                '영어           단어장',
                textAlign: TextAlign.center,
                maxLines: 2,

                style: TextStyle(
                  fontSize: 90.sp,
                  color: Colors.white
                ),
              ),
            ),
            elevation: 10,
          ),
        ),
      ),
    );
  }
}

// 