import 'package:flutter/material.dart';

// 테스트 결과 페이지
class ScorePage extends StatefulWidget {
  ScorePage({Key key, this.score}) : super(key: key);

  final Map score;

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  List _score, _value, _key, _index;

  int _correctNum = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      _score = widget.score['score'];
      _value = widget.score['value'];
      _key = widget.score['key'];
      _index = widget.score['index'];
    });

    for (int i = 0; i < _score.length; i++) {
      if (_score[i]) {
        setState(() {
          _correctNum++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결과'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Center(
              child: Text('맞은 개수 : $_correctNum / ${_score.length}'),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.green
          : null,
      body: _score == null && _value == null && _key == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _score.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  title: Text('${_key[_index[index]]}',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text('${_value[_index[index]]}',
                      style: TextStyle(color: Colors.white)),
                  trailing: _score[index]
                      ? Icon(Icons.done, color: Colors.white)
                      : Icon(Icons.clear, color: Colors.white),
                );
              }),
    );
  }
}
