import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key key, 
    this.icon, 
    this.text,
    this.actived = false,
    @required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final bool actived;
  final  onPressed;

  @override
  Widget build(BuildContext context) {
    var color = actived ? Theme.of(context).primaryColor : Color(0xFF757575);
    return FlatButton(
      child: _renderView(),
      onPressed: (){
        onPressed();
      },
      textColor: color,
      padding: EdgeInsets.all(5),
    );
  }

  Widget _renderView() {
    Widget col = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
        ),
        Text(text, style: TextStyle(fontSize: 8))
      ],
    );
    return col;
  }
}
