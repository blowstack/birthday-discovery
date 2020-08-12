import 'package:flutter/material.dart';

class DashboardItemWidget extends StatelessWidget {
  final value;
  final unit;
  final fontSize;
  final formatter;

  DashboardItemWidget(this.value, this.unit, this.fontSize, this.formatter);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: "${formatter.format(value)}",
                style: TextStyle(
                    fontSize: double.parse(fontSize.toString()),
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: unit,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
