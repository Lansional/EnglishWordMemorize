import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnglishWordToKorean extends StatefulWidget {
  EnglishWordToKorean({Key key}) : super(key: key);

  @override
  _EnglishWordToKoreanState createState() => _EnglishWordToKoreanState();
}

class _EnglishWordToKoreanState extends State<EnglishWordToKorean> {
  final databaseReference = Firestore.instance;

  Map _word;

  List _wordKey;
  List _wordValue;

  @override
  void initState() {
    super.initState();
    
    this.getData();
  }

  // get data at firebase cloudstore
  void getData() {
    databaseReference
        .collection('word')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        // print('${f.data}');
        setState(() {
          this._word = f.data;

          this._wordKey = _word.keys.toList();
          this._wordValue = _word.values.toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: _word == null && _wordKey == null && _wordValue == null ? Center(
        child: CircularProgressIndicator(),
      ) : Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Swiper(
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 10.w,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  elevation: 4,
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('${_wordKey[index]}', style: TextStyle(
                            fontSize: 150.sp
                          )),
                          Text('${_wordValue[index]}', style: TextStyle(
                            fontSize: 50.sp
                          ))
                        ],
                      ),
                    )
                  ),
                );
              },
              itemWidth: 1000.w,
              itemHeight: 1500.h,
              layout: SwiperLayout.TINDER,
              itemCount: _word.length,
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