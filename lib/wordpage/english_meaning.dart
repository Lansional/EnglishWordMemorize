import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class EnglishMeaning extends StatefulWidget {
  EnglishMeaning({Key key, this.unit}) : super(key: key);

  final String unit;

  @override
  _EnglishMeaningState createState() => _EnglishMeaningState();
}

class _EnglishMeaningState extends State<EnglishMeaning> {
  final databaseReference = Firestore.instance;

  int _cardWidth = 800;
  int _cardHeight = 1300;

  Map _word;

  List _wordKey;
  List _wordValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void getData() {
    databaseReference
      .collection('word')
      .document('CSAT')
      .get()
      .then((f) {
        setState(() {
          this._word = f.data;

          this._wordKey = _word.keys.toList();
          this._wordValue = _word.values.toList();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.green : null,
      body: _wordKey == null && _wordValue == null ? Center(
        child: CircularProgressIndicator(),
      ) : Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Swiper(
              layout: SwiperLayout.CUSTOM,
              customLayoutOption: new CustomLayoutOption(
                  startIndex: -1,
                  stateCount: 3
              ).addRotate([
                -45.0/180,
                0.0,
                45.0/180
              ]).addTranslate([
                new Offset(-370.0, -40.0),
                new Offset(0.0, 0.0),
                new Offset(370.0, -40.0)
              ]),
              itemWidth: _cardWidth.w,
              itemHeight: _cardHeight.h,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // side: BorderSide(
                    //   width: 20.w,
                    //   color: Theme.of(context).primaryColor
                    // ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('${_wordKey[index]}', style: TextStyle(
                        fontSize: 135.sp
                      )),
                      Container(
                        width: 600.h,
                        child: TextField(
                          decoration: InputDecoration(
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: _word.length
            ),
          )
        ],
      )
    );
  }
}