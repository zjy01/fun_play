import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Account();
}

class _Account extends State<Account> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Account inistate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        elevation: 0,
        title: Text("分类"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: _render(),
    );
  }

  _render() {
    return Container(
      constraints:BoxConstraints.expand(),
      child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _renderUserBox(),
          Center(
  child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        ButtonTheme.bar( // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () { /* ... */ },
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () { /* ... */ },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
Center(
  child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        ButtonTheme.bar( // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () { /* ... */ },
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () { /* ... */ },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
Center(
  child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        ButtonTheme.bar( // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () { /* ... */ },
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () { /* ... */ },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
Center(
  child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        ButtonTheme.bar( // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () { /* ... */ },
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () { /* ... */ },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
Center(
  child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        ButtonTheme.bar( // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () { /* ... */ },
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () { /* ... */ },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
)
        ],
      ),
    ),
    );
  }

  _renderUserBox() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(height: 120),
        ),
        Container(
          constraints: BoxConstraints.expand(height: 60),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        Positioned(
          top: 20,
          left: 10,
          right: 10,
          child: _renderUser(),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Text('来一句地表最强的自我介绍吧', style: TextStyle(color: Color(0xff757575)),),
        )
      ],
    );
  }

  _renderUser() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "http://icon.nipic.com/BannerPic/20190318/original/20190318094507_1.jpg",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
                constraints: BoxConstraints.expand(height: 80),
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: _renderDivideFlex([
                  _renderDivideFlex([
                    Text('张二狗',style: TextStyle(color: Colors.white, fontSize: 20)),
                    RaisedButton(child: Text('修改资料'), color: Theme.of(context).primaryColorDark, textColor: Colors.white, onPressed: (){},),
                  ], 'Row'),
                  _renderDivideFlex([
                    _renderNumText('2', '关注'),
                    _renderNumText('8', '粉丝'),
                    _renderNumText('8', '被赞'),
                  ], 'Row')
                ], 'Column')),
          )
        ],
      ),
    );
  }

  Widget _renderDivideFlex(List<Widget> childs, [flex]) {
    List<Widget> children = childs.map((item) {
      return Expanded(child: item);
    }).toList();
    return flex == 'Column'
        ? Column(
            children: children,
          )
        : Row(
            children: children,
          );
  }

  _renderNumText(String number, String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
      Text(number, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, textBaseline: TextBaseline.ideographic),),
      Text(text, style: TextStyle(textBaseline: TextBaseline.ideographic),),
    ],);
  }
}
