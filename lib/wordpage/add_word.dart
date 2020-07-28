import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWord extends StatefulWidget {
  AddWord({Key key, this.arguments}) : super(key: key);

  final String arguments;

  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final _engWord = new TextEditingController();
  final _engWordMean = new TextEditingController();

  var _listViewChildren = <Widget>[];

  Map<String, String> _newWord = {};

  int _listTileIndex = 0;

  bool _autoRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('단어추가'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => _addChildren())
          ],
        ),
        body: _listViewChildren.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error_outline, size: 100),
                    Text('\'+\' 아이콘을 클릭하여 단어추가',
                        style: TextStyle(fontSize: 50.sp))
                  ],
                ),
              )
            : _autoRefresh
                ? ListView(
                    children: _listViewChildren,
                  )
                : Center(child: CircularProgressIndicator()));
  }

  void _addChildren() {
    final double width = 750;
    final double height = 530;

    setState(() {
      _autoRefresh = false;
    });

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: SizedBox(
                  width: width.w,
                  height: height.h,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('영어단어: '),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: SizedBox(
                              width: (width - 215).w,
                              child: TextField(
                                controller: _engWord,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text('뜻: '),
                          Padding(
                            padding: EdgeInsets.fromLTRB(53, 0, 0, 0),
                            child: SizedBox(
                              width: (width - 210).w,
                              child: TextField(
                                controller: _engWordMean,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: (width - 500).w,
                          ),
                          OutlineButton(
                              child: Text('확인'),
                              onPressed: () {
                                String word = _engWord.text.trim();
                                String mean = _engWordMean.text.trim();

                                setState(() {
                                  _newWord['$word'] = '$mean';
                                  _engWord.text = '';
                                  _engWordMean.text = '';
                                  _listTileIndex++;
                                });

                                print('word: $word, mean: $mean');

                                _listViewChildren.add(ListTile(
                                  leading: Text('$_listTileIndex'),
                                  title: Text('$word'),
                                  subtitle: Text('$mean'),
                                ));

                                setState(() {
                                  _autoRefresh = true;
                                });

                                print(_listViewChildren);

                                Navigator.pop(context);
                              }),
                          SizedBox(
                            width: 30.w,
                          ),
                          OutlineButton(
                              child: Text('취소',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                setState(() {
                                  _engWord.text = '';
                                  _engWordMean.text = '';
                                  _autoRefresh = true;
                                });
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    ],
                  )),
            ));
  }
}
