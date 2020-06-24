import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WordUnitChoose extends StatefulWidget {
  WordUnitChoose({Key key}) : super(key: key);

  @override
  _WordUnitChooseState createState() => _WordUnitChooseState();
}

class _WordUnitChooseState extends State<WordUnitChoose> {

  List _documentsName = [
    '수능',
    'unit 11',
    '',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil.screenWidth,
              height: 1200.h,
              child: Swiper(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          width: 30.w,
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                      elevation: 4,
                      child: Center(
                        child: Text(
                          '${_documentsName[index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 160.sp
                          )
                        ),
                      )
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.pushNamed(context, '/englishWord', arguments: 'CSAT');
                          break;
                        case 1:
                          Navigator.pushNamed(context, '/englishWord', arguments: 'unit 11');
                          break;
                          
                        default:                        
                      }
                    },
                  );
                },
                viewportFraction: 0.8,
                scale: 0.9,
                itemCount: _documentsName.length,
                pagination: SwiperPagination(
                  margin: EdgeInsets.only(bottom: 50.w)
                ),
              ),
            )
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: ScreenUtil.screenHeightDp - 1850.h),        // any device height
              child: BackButton(color: Colors.white)
            ),
          ),
        ],
      )
    );
  }
}