import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('MessageList inistate');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("消息"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Text('消息'),
    );
  }
}