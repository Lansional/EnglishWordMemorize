import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValidatorPage extends StatefulWidget {
  ValidatorPage({Key key, this.check}) : super(key: key);

  final Map check;

  @override
  _ValidatorPageState createState() => _ValidatorPageState();
}

class _ValidatorPageState extends State<ValidatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green
          : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('준비되셨습니까?', style: TextStyle(fontSize: 130.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/meaning',
                          arguments: widget.check);
                    }),
                RaisedButton(
                    color: Colors.red,
                    child: Text('취소'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
