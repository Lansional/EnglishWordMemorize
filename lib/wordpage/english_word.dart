
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnglishWordToKorean extends StatefulWidget {
  EnglishWordToKorean({Key key}) : super(key: key);

  @override
  _EnglishWordToKoreanState createState() => _EnglishWordToKoreanState();
}

class _EnglishWordToKoreanState extends State<EnglishWordToKorean> {
  final databaseReference = Firestore.instance;

  // get data at firebase cloudstore
  void getData() {
    databaseReference
        .collection('word')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영어보고 한글 쓰기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                getData();
              }
            ),
            Text('')
          ],
        ),
      )
    );
  }
}