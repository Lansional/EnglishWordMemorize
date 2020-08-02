import 'package:english_word_memorize/documentsNameEnum.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WordUnitChoose extends StatefulWidget {
  WordUnitChoose({Key key, this.arguments}) : super(key: key);

  final Map arguments;

  @override
  _WordUnitChooseState createState() => _WordUnitChooseState();
}

class _WordUnitChooseState extends State<WordUnitChoose> {
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
                                child: Text('${unit[index]}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 160.sp)),
                              ),
                            )),
                        onTap: () {
                          // Navigator.pop(context);
                          if (widget.arguments['test']) {
                            switch (index) {
                              case 0:
                                Navigator.pushNamed(context, '/englishWord',
                                    arguments: '${unit[0]}');
                                break;
                              case 1:
                                Navigator.pushNamed(context, '/englishWord',
                                    arguments: '${unit[1]}');
                                break;
                              case 2:
                                Navigator.pushNamed(context, '/englishWord',
                                    arguments: '${unit[2]}');
                                break;
                              case 3:
                                Navigator.pushNamed(context, '/englishWord',
                                    arguments: '${unit[3]}');
                                break;
                              default:
                            }
                          } else {
                            switch (index) {
                              case 0:
                                Navigator.pushNamed(context, '/meaning',
                                    arguments: {'unit': unit[0]});
                                break;
                              case 1:
                                Navigator.pushNamed(context, '/meaning',
                                    arguments: {'unit': unit[1]});
                                break;
                              case 2:
                                Navigator.pushNamed(context, '/meaning',
                                    arguments: {'unit': unit[2]});
                                break;
                              case 3:
                                Navigator.pushNamed(context, '/meaning',
                                    arguments: {'unit': unit[3]});
                                break;
                              default:
                            }
                          }
                        },
                      );
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                    itemCount: unit.length,
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
