import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnglishMeaning extends StatefulWidget {
  EnglishMeaning({Key key}) : super(key: key);

  @override
  _EnglishMeaningState createState() => _EnglishMeaningState();
}

class _EnglishMeaningState extends State<EnglishMeaning> {
  final databaseReference = Firestore.instance;

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
      body: SizedBox(
        height: 200.h,
      ),
    );
  }
}