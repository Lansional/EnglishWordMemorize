import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    print('$_key');
    print('$_value');

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
      // backgroundColor: Theme.of(context).brightness == Brightness.light
      //     ? Colors.green
      //     : null,
      body: _score == null && _value == null && _key == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _score.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}', textAlign: TextAlign.center),
                  title: Text(
                    '${_key[_index[index]]}',
                  ),
                  subtitle: Text('${_value[_index[index]]}'),
                  trailing:
                      _score[index] ? Icon(Icons.done) : Icon(Icons.clear),
                );
              }),
    );
  }

  _increment() async {
    var list = <String>[];

    for (int i = 0; i < _value.length; i++) {
      list.add('${_value[i]}');
    }

    print(list);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('score_key', _key);
    await prefs.setStringList('score_value', list);
  }

  @override
  void dispose() {
    _increment();

    super.dispose();
  }
}
