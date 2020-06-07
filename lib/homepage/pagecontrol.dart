import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageControl extends StatefulWidget {
  PageControl({Key key}) : super(key: key);

  @override
  _PageControlState createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {

  double _cardWidth = 850;      // 넓이
  double _cardHeight = 400;     // 높이
  double _cardTextSize = 90;    // 글꼴 크기

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
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              '한글보고 영어 쓰기',
              style: TextStyle(
                fontSize: _cardTextSize.sp,
                color: Colors.white
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
                fontSize: _cardTextSize.
                sp
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
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _cardToEngTap(),
            SizedBox(
              height: 100.h,
            ),
            _cardToKorTap()
          ],
        ),
      ),
    );
  }
}
