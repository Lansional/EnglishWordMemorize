import 'package:flutter/material.dart';

class AddWord extends StatefulWidget {
  AddWord({Key key}) : super(key: key);

  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단어추가'),
      ),
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
