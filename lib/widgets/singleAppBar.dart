import 'package:flutter/material.dart';

class SingleAppBar extends StatefulWidget implements PreferredSizeWidget {

  SingleAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SingleAppBarState createState() => _SingleAppBarState();
}

class _SingleAppBarState extends State<SingleAppBar> {

  final Color inactiveMenuColor = Color(0xFFFFFFFF);
  final Color activeButtonColor = Color(0xFFFFD54F);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
