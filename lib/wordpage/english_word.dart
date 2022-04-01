import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slimy_card/slimy_card.dart';

class EnglishWord extends StatefulWidget {
  EnglishWord({Key key, this.documents}) : super(key: key);

  final String documents;

  @override
  _EnglishWordState createState() => _EnglishWordState();
}

class _EnglishWordState extends State<EnglishWord> {
  final databaseReference = Firestore.instance;

  final double _radius = 20;

  List _wordKey;
  List _wordValue;

  bool _noAnyWrongWord = false;

  @override
  void initState() {
    super.initState();

    widget.documents == 'wrongWord' ? this._wrongWordData() : this._getData();
  }

  // get data at firebase cloudstore
  void _getData() {
    databaseReference
        .collection('word')
        .document(widget.documents)
        .get()
        .then((f) {
      var word = f.data;
      setState(() {
        this._wordKey = word.keys.toList();
        this._wordValue = word.values.toList();
      });
    });
  }

  void _wrongWordData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> key = prefs.getStringList('score_key');
    List<String> value = prefs.getStringList('score_value');

    if (key == null) {
      setState(() {
        _noAnyWrongWord = true;
      });
    } else {
      setState(() {
        this._wordKey = key.map((e) => e).toList();
        this._wordValue = value.map((e) => e).toList();
      });

      prefs.remove('score_key');
      prefs.remove('score_value');
      setState(() {
        _noAnyWrongWord = false;
      });
    }
  }

  _topCardWidget(int index) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_radius)),
          border: Border.all(width: 5, color: Colors.white)),
      child: Center(
        child: Text('${_wordKey[index]}',
            style: TextStyle(fontSize: 120.sp, color: Colors.white)),
      ));

  _bottomCardWidget(int index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_radius)),
            border: Border.all(width: 5, color: Colors.white)),
        child: Center(
          child: Text('${_wordValue[index]}',
              style: TextStyle(fontSize: 50.sp, color: Colors.white)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green
            : null,
        body: _noAnyWrongWord
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.report_problem, color: Colors.white, size: 90),
                  Text('???? 틀린 단어가 없습니다.',
                      style: TextStyle(fontSize: 90.sp, color: Colors.white),
                      textAlign: TextAlign.center),
                  SizedBox(height: 30.h),
                  OutlineButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.chevron_left, color: Colors.white),
                      label:
                          Text('뒤로 가기', style: TextStyle(color: Colors.white)))
                ],
              ))
            : _wordKey == null && _wordValue == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Swiper(
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(_radius),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 5,
                                    )),
                                padding: EdgeInsets.only(top: 5),
                                margin: EdgeInsets.fromLTRB(5, 35, 5, 50),
                                child: SlimyCard(
                                  color: Theme.of(context).primaryColor,
                                  width: 380,
                                  topCardHeight: 400,
                                  bottomCardHeight: 100,
                                  borderRadius: _radius,
                                  topCardWidget: _topCardWidget(index),
                                  bottomCardWidget: _bottomCardWidget(index),
                                  slimeEnabled: true,
                                ),
                              );
                            },
                            itemWidth: ScreenUtil.screenWidth,
                            itemHeight: ScreenUtil.screenHeight,
                            layout: SwiperLayout.TINDER,
                            itemCount: _wordKey.length,
                          )),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.only(top: 65),
                            child: Text(
                              '* 괄호안에 있는 영어단어는 동의어 입니다.',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 40.sp),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.screenHeightDp -
                                    1800.h), // any device height
                            child: BackButton(color: Colors.white)),
                      ),
                    ],
                  ));
  }
}
