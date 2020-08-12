import 'package:flutter/material.dart';

class CircularLoaderWidget extends StatelessWidget {
  final height;
  final width;
  final strokeWidth;

  CircularLoaderWidget(this.height, this.width, this.strokeWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(strokeWidth: double.parse(strokeWidth.toString())),
                height: double.parse(height.toString()),
                width: double.parse(width.toString()),
              )
            ]));
  }
}
