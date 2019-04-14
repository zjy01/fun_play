import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './HomePage.dart';
import '../util/http.dart';
import '../util/const.dart';

class ClassList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClassList();
}

class _ClassList extends State<ClassList> with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["衣", "食", "住", "行", "其他"];
  List<Map> mvs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchVideo();
    print('class list inistate');
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
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
        bottom: TabBar(
            //生成Tab菜单
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: renderList(),
    );
  }

  renderList() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      children: mvs.map((item) {
        return renderVideo(item);
      }).toList(),
    );
  }

  Widget renderVideo(item) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("$HOST/${item['thumb']}"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Text(
                '${item['video']}',
                style: TextStyle(color: Colors.white),
              ),
              bottom: 5,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context){
          return HomePage(video: item,);
        }));
      },
    );
  }

  _fetchVideo() async {
    var dio = Http();
    Response<List> resp = await dio.get('/video/recommend');
    setState(() {
      mvs = resp.data.map((t) {
        return {'video': t['video'], 'thumb': t['thumb']};
      }).toList();
    });
  }
}
