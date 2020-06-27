import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class EnglishMeaning extends StatefulWidget {
  EnglishMeaning({Key key, this.unit}) : super(key: key);

  final String unit;

  @override
  _EnglishMeaningState createState() => _EnglishMeaningState();
}

class _EnglishMeaningState extends State<EnglishMeaning> with SingleTickerProviderStateMixin {
  final databaseReference = Firestore.instance;

  DateTime _backbuttonpressedTime;

  final SwiperController _swiperController = new SwiperController();
  final TextEditingController _textEditingController = new TextEditingController();

  // Animation<double> _animation;
  AnimationController _animationController;

  int _cardWidth = 800;
  int _cardHeight = 1300;

  Map _word;

  List _wordKey;
  List _wordValue;

  var _scoreCheck = <bool>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _animationController = new AnimationController(
    //   vsync: this,
    //   duration: Duration(
    //     seconds: 3
    //   )
    // );

    _getData();
  }

  void _getData() {
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

  _stackBody() {
    return Swiper(
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
            side: BorderSide(
              width: 20.w,
              color: Theme.of(context).primaryColor
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${_wordKey[index]}', style: TextStyle(
                fontSize: 135.sp
              )),
              SizedBox(
                height: 150.h,
              ),
              Container(
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
              SizedBox(
                height: 150.h,
              ),
              Icon(Icons.add, size: 150.w)
            ],
          ),
        );
              },
              itemCount: _word.length
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.green : null,
      body: _wordKey == null && _wordValue == null ? Center(
        child: CircularProgressIndicator(),
      ) : _stackBody()
    );
  }

  _popup() {
    return Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('지금 나간다면 점수가 없어집니다.'),
      action: SnackBarAction(
        label: '확인',
        onPressed: () {
          Navigator.pop(context);
        }
      ),
    ));
  } 
}