import 'package:flutter/material.dart';

class  EmptyAppBar  extends StatelessWidget implements PreferredSizeWidget {
  final Color color;

  EmptyAppBar({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: color);
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}