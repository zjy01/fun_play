import 'package:flutter/material.dart';

import '../component/IconTextButton.dart';
import './HomePage.dart';
import './ClassList.dart';
import './MessageList.dart';
import './Account.dart';
// import './Publish.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepOrange,
        // bottomAppBarColor: Color(0x)
      ),
      home: new _AppRoute(),
    );
  }
}

class _AppRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppRouteState();
}

class _AppRouteState extends State<_AppRoute>
  with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Map _compMap = {};
  TabController _tabController; //需要定义一个Controller
  List tabs = [
    {'icon': Icons.home, 'title': '首页', 'loader':() => new HomePage()},
    {'icon': Icons.list, 'title': '分类', 'loader':() => new ClassList()},
    {'key': 'publish', 'title': '发布','loader':() => new ClassList()},
    {'icon': Icons.message, 'title': '消息', 'loader':() => new MessageList()},
    {'icon': Icons.person, 'title': '我的', 'loader':() => new Account()},
  ];

  @override
  void initState() {
    super.initState();
    print('initState');
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex=_tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentComp =tabs[_selectedIndex];
    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: _renderBottomBar(),
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //悬浮按钮
        child: Icon(Icons.add),
        onPressed:() => _onItemTapped(2)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:  _loader(currentComp['title'], currentComp['loader']),
    );
  }

  List _renderBottomBar() {
    print(_tabController.index);
    List<Widget> navs = [];
    tabs.asMap().forEach((index, item) {
      if (item['icon'] != null) {
        navs.add(IconTextButton(
          icon: item['icon'],
          text: item['title'],
          onPressed: () => _onItemTapped(index),
          actived: index == _selectedIndex,
        ));
      } else {
        navs.add(SizedBox());
      }
    });
    return navs;
  }

  void _onItemTapped(index) {
    _tabController.animateTo(index);
  }

  Widget _loader(key, comp){
    if(_compMap[key] == null){
      _compMap[key] = comp();
    } 
    return _compMap[key];
  }
}
