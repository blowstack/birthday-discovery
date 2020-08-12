import 'package:flutter/material.dart';

class SharedAppBar extends StatefulWidget implements PreferredSizeWidget {
  SharedAppBar({Key key})
      : preferredSize = Size.fromHeight(0),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SharedAppBarState createState() => _SharedAppBarState();
}

class _SharedAppBarState extends State<SharedAppBar> {

  final Color inactiveMenuColor = Color(0xFFFFFFFF);
  final Color activeButtonColor = Color(0xFFFFD54F);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
    );
  }
}
