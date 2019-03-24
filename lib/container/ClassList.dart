import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ClassList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClassList();
}

class _ClassList extends State<ClassList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('class list inistate');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("分类"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Text('分类'),
    );
  }
}