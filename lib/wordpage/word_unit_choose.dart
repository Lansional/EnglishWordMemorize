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
    'Unit 12',
    'Unit 13',
    'Unit 14',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green
            : null,
        body: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Container(
                  width: ScreenUtil.screenWidth,
                  height: 1200.h,
                  child: Swiper(
                    control: SwiperControl(color: Colors.black),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side:
                                  BorderSide(width: 30.w, color: Colors.white),
                            ),
                            color: Colors.blue,
                            elevation: 4,
                            child: Container(
                              child: Center(
                                child: Text('${_documentsName[index]}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 160.sp)),
                              ),
                            )),
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.pushNamed(context, '/englishWord',
                                  arguments: 'CSAT');
                              break;
                            case 1:
                              Navigator.pushNamed(context, '/englishWord',
                                  arguments: '${_documentsName[1]}');
                              break;
                            case 2:
                              Navigator.pushNamed(context, '/englishWord',
                                  arguments: '${_documentsName[2]}');
                              break;
                            case 3:
                              Navigator.pushNamed(context, '/englishWord',
                                  arguments: '${_documentsName[3]}');
                              break;
                            default:
                          }
                        },
                      );
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                    itemCount: _documentsName.length,
                    pagination:
                        SwiperPagination(margin: EdgeInsets.only(top: 10.w)),
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.screenHeightDp -
                          1800.h), // any device height
                  child: BackButton(color: Colors.white)),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.w),
                  child: Text(
                    '카드를 클릭하세요',
                    style: TextStyle(color: Colors.white, fontSize: 50.sp),
                  ),
                ))
          ],
        ));
  }
}
