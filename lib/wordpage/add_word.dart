import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

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

  final databaseReference = Firestore.instance;

  var _newWordKey = <String>[];
  var _newWordValue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getAllWord();
  }

  void _getAllWord() {
    databaseReference.collection('word').document(widget.arguments == '수능' ? 'CSAT' : widget.arguments).get().then((f) {
      var word = f.data;
      setState(() {
        this._newWordKey = word.keys.toList();
        this._newWordValue = word.values.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('단어추가 (${widget.arguments})'),
          actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () => _addChildren())],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _updateData();
            Navigator.pop(context);
          },
          child: Icon(Icons.done, color: Colors.white),
        ),
        body: _newWordKey.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 30,
                    ),
                    // Icon(Icons.error_outline, size: 100),
                    Text('\'+\' 아이콘을 클릭하여 단어추가', style: TextStyle(fontSize: 50.sp)),
                    Text('카드를 오른쪽에서 왼쪽으로 스와이프하여 단어를 삭제', style: TextStyle(fontSize: 30.sp)),
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
                            _listKey.currentState.removeItem(index, (context, animation) => Container());
                            _deleteData(index);
                            setState(() {
                              _newWordKey.removeAt(index);
                              _newWordValue.removeAt(index);
                            });
                          },
                          background: Card(
                            child: Container(color: Colors.red),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Text('${_newWordKey[index]}'),
                              subtitle: Text('${_newWordValue[index]}'),
                            ),
                          )),
                    )));
  }

  void _deleteData(int index) {
    databaseReference
        .collection('word')
        .document(widget.arguments == '수능' ? 'CSAT' : widget.arguments)
        .updateData({_newWordKey[index]: FieldValue.delete()}).whenComplete(() {
      print('${_newWordKey[index]} Field Deleted');
    });
  }

  void _updateData() {
    try {
      for (int i = 0; i < _newWordKey.length; i++) {
        databaseReference
            .collection('word')
            .document(widget.arguments == '수능' ? 'CSAT' : widget.arguments)
            .updateData({_newWordKey[i]: _newWordValue[i]});
      }
    } catch (e) {
      print(e);
    }
    Toast.show('업로드 되었습니다.', context);
  }

  void _addChildren() {
    final double width = 1050;
    final double height = 773;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                                  width: (width - 515).w,
                                  child: TextFormField(
                                    controller: _engWord,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '아무것도 입력하지 않았습니다.';
                                      }
                                      return null;
                                    },
                                    decoration:
                                        InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
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
                                  width: (width - 510).w,
                                  child: TextFormField(
                                    controller: _engWordMean,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '아무것도 입력하지 않았습니다.';
                                      }
                                      return null;
                                    },
                                    decoration:
                                        InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(260.h, 30.h, 0, 10.h),
                            child: Row(
                              children: <Widget>[
                                OutlinedButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      String word = _engWord.text.trim();
                                      String mean = _engWordMean.text.trim();

                                      List upload = mean.split(', ');

                                      if (_formkey.currentState.validate()) {
                                        _newWordKey.add(word);
                                        if (upload.length <= 1) {
                                          print('mean: $mean');
                                          _newWordValue.add(mean);
                                        } else {
                                          _newWordValue.add(upload);
                                        }

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
                                OutlinedButton(
                                    child: Text('취소', style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      setState(() {
                                        _engWord.text = '';
                                        _engWordMean.text = '';
                                      });
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ),
                          Text('여러가지 뜻을 가지고 있는 단어는 \', \'로 추가해주세요.',
                              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold))
                        ],
                      ))),
            ));
  }
}
