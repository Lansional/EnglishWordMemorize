// import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // void _changeBrightness() {
  //   DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  // }

  // void changeColor() {
  //   DynamicTheme.of(context).setThemeData(new ThemeData(
  //       primaryColor: Theme.of(context).primaryColor == Colors.indigo? Colors.red: Colors.indigo
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('디자인'),
            subtitle: Text('테마 바꾸기'),
            onTap: () {
              // _changeBrightness();
            },
          )
        ],
      ),
    );
  }
}
