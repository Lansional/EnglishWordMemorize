import 'dart:math';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Meaning extends StatefulWidget {
  Meaning({Key key, this.arguments}) : super(key: key);

  final Map arguments;

  @override
  _MeaningState createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> with SingleTickerProviderStateMixin {
  final databaseReference = Firestore.instance;

  final SwiperController _swiperController = new SwiperController();

  List _wordKey;
  List _wordValue;

  var _cardList = <Widget>[];
  var _randomList = <int>[];
  var _chooseButton = <String>[];

  var _score = <bool>[];

  final int _setMaxNum = 20;

  // var _buttonColor = Colors.red;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() {
    databaseReference
        .collection('word')
        .document(widget.arguments['unit'])
        .get()
        .then((f) {
      var wordKey = f.data.keys.toList();
      var wordValue = f.data.values.toList();

      setState(() {
        this._wordKey = wordKey.getRange(0, _setMaxNum).toList();
        this._wordValue = wordValue.getRange(0, _setMaxNum).toList();
      });

      for (int i = 0; i < _setMaxNum; i++) {
        setState(() {
          this._randomList.add(Random().nextInt(_wordKey.length));
        });

        _score.add(false);
        _randomButton(i);

        setState(() {
          _cardList.add(_swiperCardChildren(i));
          _chooseButton.clear();
        });
      }
    });
  }

  _randomButton(int index) {
    int randomNum = 0;

    var thisWord = _randomList[index];
    // print(thisWord);

    for (int i = 0; i < 4; i++) {
      setState(() {
        randomNum = Random().nextInt(_setMaxNum);
        _chooseButton.add(_wordKey[randomNum]);
        // print('$i: $randomNum, ${_chooseButton}');
      });
    }

    _chooseButton[Random().nextInt(4)] = _wordKey[thisWord];
  }

  _swiperCardChildren(int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 50),
      child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:
                BorderSide(width: 20.w, color: Theme.of(context).primaryColor),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200.h,
                    ),
                    Text(
                      '${_wordValue[_randomList[index]]}',
                      style: TextStyle(fontSize: 90.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 150),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: _chooseButton
                            .map((String e) => Container(
                                  width: 550.w,
                                  height: 150.h,
                                  padding: EdgeInsets.only(top: 10),
                                  child: OutlineButton(
                                    child: Text('$e',
                                        style: TextStyle(fontSize: 50.sp)),
                                    onPressed: () {
                                      if (e == _wordKey[_randomList[index]]) {
                                        _score[index] = true;
                                        print('$index: 맞습니다.');
                                      }
                                      if (index == _setMaxNum - 1) {
                                        print('asdf');
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/score',
                                            arguments: {
                                              'score': _score,
                                              'key': _wordKey,
                                              'value': _wordValue,
                                              'index': _randomList
                                            });
                                      } else {
                                        _swiperController.next();
                                      }
                                    },
                                  ),
                                ))
                            .toList())),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text('${index + 1} / ${_wordKey.length}'),
                  ))
            ],
          )),
    );
  }

  _cardBody() {
    return Swiper.children(
      viewportFraction: 0.8,
      scale: 0.9,
      loop: false,
      controller: _swiperController,
      children: _cardList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green
            : null,
        body: _wordKey == null && _wordValue == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _cardBody());
  }
}
