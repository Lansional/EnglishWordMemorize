import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 영어보고 한글 뜻 쓰는 테스트 페이지 (바꿀꺼임)
class EnglishWord extends StatefulWidget {
  EnglishWord({Key key, this.documents}) : super(key: key);

  final String documents;

  @override
  _EnglishWordState createState() => _EnglishWordState();
}

class _EnglishWordState extends State<EnglishWord> {
  final databaseReference = Firestore.instance;

  Map _word;

  List _wordKey;
  List _wordValue;

  @override
  void initState() {
    super.initState();

    widget.documents == 'wrongWord' ? this._wrongWordData() : this._getData();
  }

  // get data at firebase cloudstore
  void _getData() {
    databaseReference
        .collection('word')
        .document('${widget.documents}')
        .get()
        .then((f) {
      setState(() {
        this._word = f.data;

        this._wordKey = _word.keys.toList();
        this._wordValue = _word.values.toList();
      });
    });
  }

  void _wrongWordData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> key = prefs.getStringList('score_key');
    List<String> value = prefs.getStringList('score_value');

    print('key: $key, value: $value');

    setState(() {
      this._wordKey = key.map((e) => e).toList();
      this._wordValue = value.map((e) => e).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: _wordKey == null && _wordValue == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Swiper(
                        itemBuilder: (context, index) {
                          return
                              // FlipCard(
                              //   key: cardKey,
                              //   flipOnTouch: false,
                              //   front: Container(
                              //     child: RaisedButton(
                              //       onPressed: () => cardKey.currentState.toggleCard(),
                              //       child: Text('Toggle'),
                              //     ),
                              //   ),
                              //   back: Container(
                              //     child: Text('Back'),
                              //   ),
                              // );
                              Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  width: 10.w,
                                  color: Theme.of(context).primaryColor),
                            ),
                            elevation: 4,
                            child: Container(
                                child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('${_wordKey[index]}',
                                      style: TextStyle(fontSize: 120.sp)),
                                  Text('${_wordValue[index]}',
                                      style: TextStyle(fontSize: 50.sp))
                                ],
                              ),
                            )),
                          );
                        },
                        itemWidth: 1000.w,
                        itemHeight: 1500.h,
                        layout: SwiperLayout.TINDER,
                        itemCount: _wordKey.length,
                      )),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil.screenHeightDp -
                                1850.h), // any device height
                        child: BackButton(color: Colors.white)),
                  ),
                ],
              ));
  }
}
