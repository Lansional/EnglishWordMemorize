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

  final SwiperController _swiperController = new SwiperController();
  final TextEditingController _textEditingController = new TextEditingController();

  Animation<double> _animation;
  AnimationController _animationController;

  int _cardWidth = 800;
  int _cardHeight = 1300;

  Map _word;

  List _wordKey;
  List _wordValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _animation = new 

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
            child: IgnorePointer(
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
                loop: false,
                pagination: SwiperPagination(),
                controller: _swiperController,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${_wordKey[index]}', style: TextStyle(
                          fontSize: 135.sp
                        )),
                        SizedBox(
                          height: 500.h,
                        ),
                        Icon(Icons.add, size: 150.w)
                      ],
                    ),
                  );
                },
                itemCount: _word.length
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 600.h,
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onSubmitted: (str) {        // keyboard enter
                  _swiperController.next();
                  setState(() {
                    _textEditingController.text = '';
                  });
                },
              ),
            ),
          )
        ],
      )
    );
  }
}