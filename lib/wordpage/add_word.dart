import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWord extends StatefulWidget {
  AddWord({Key key, this.arguments}) : super(key: key);

  final String arguments;

  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> with SingleTickerProviderStateMixin {
  final _listKey = new GlobalKey<AnimatedListState>();
  final _engWord = new TextEditingController();
  final _engWordMean = new TextEditingController();
  final _formkey = new GlobalKey<FormState>();

  var _newWordKey = <String>[];
  var _newWordValue = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('단어추가 (${widget.arguments})'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => _addChildren())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.done, color: Colors.white),
        ),
        body: _newWordKey.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error_outline, size: 100),
                    Text('\'+\' 아이콘을 클릭하여 단어추가',
                        style: TextStyle(fontSize: 50.sp)),
                    Text('카드를 오른쪽에서 왼쪽으로 스와이프하여 단어를 삭제',
                        style: TextStyle(fontSize: 30.sp)),
                  ],
                ),
              )
            : AnimatedList(
                key: _listKey,
                initialItemCount: _newWordKey.length,
                itemBuilder: (context, index, animation) => SizeTransition(
                      // axis: Axis.vertical,
                      sizeFactor: animation,
                      child: Dismissible(
                          key: Key(_newWordKey[index]),
                          onDismissed: (direction) {
                            _listKey.currentState.removeItem(
                                index, (context, animation) => Container());
                            setState(() {
                              _newWordKey.removeAt(index);
                              _newWordValue.removeAt(index);
                            });
                          },
                          background: Card(
                            child: Container(color: Colors.red),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Text('${_newWordKey[index]}'),
                              subtitle: Text('${_newWordValue[index]}'),
                            ),
                          )),
                    )));
  }

  void _addChildren() {
    final double width = 750;
    final double height = 673;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: SizedBox(
                  width: width.w,
                  height: height.h,
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('영어단어: '),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: SizedBox(
                                  width: (width - 215).w,
                                  child: TextFormField(
                                    controller: _engWord,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '아무것도 입력하지 않았습니다.';
                                      }
                                      return null;
                                    },
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
                                  child: TextFormField(
                                    controller: _engWordMean,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '아무것도 입력하지 않았습니다.';
                                      }
                                      return null;
                                    },
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

                                    if (_formkey.currentState.validate()) {
                                      _newWordKey.add(word);
                                      _newWordValue.add(mean);

                                      if (_newWordKey.length > 1) {
                                        int index = _newWordKey.length - 1;
                                        _listKey.currentState.insertItem(index);
                                      }

                                      setState(() {
                                        _engWord.text = '';
                                        _engWordMean.text = '';
                                      });

                                      Navigator.pop(context);
                                    }
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
                                    });
                                    Navigator.pop(context);
                                  }),
                            ],
                          )
                        ],
                      ))),
            ));
  }
}
