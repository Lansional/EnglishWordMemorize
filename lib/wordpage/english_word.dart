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

    setState(() {
      this._wordKey = key.map((e) => e).toList();
      this._wordValue = value.map((e) => e).toList();
    });
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
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(_radius),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 5,
                                )),
                            padding: EdgeInsets.only(top: 5),
                            margin: EdgeInsets.fromLTRB(5, 20, 5, 15),
                            child: SlimyCard(
                              color: Theme.of(context).primaryColor,
                              width: 380,
                              topCardHeight: 400,
                              // bottomCardHeight: 120,
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
