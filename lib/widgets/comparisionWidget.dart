import 'package:birthday_discovery/widgets/comparisionItemWidget.dart';
import 'package:flutter/material.dart';

class ComparisionWidget extends StatelessWidget {
  final title;
  final subTitle;
  final formatter;
  final futureCurrentData;
  final futurePastData;
  final futureCounter;

  ComparisionWidget(
      this.title, this.subTitle, this.futurePastData, this.futureCurrentData, this.futureCounter, this.formatter);


  generateSubtitle() {
    if (subTitle != null) {
      return Container(
        margin: EdgeInsets.only(top: 5.0),
        child: Text('$subTitle',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Text('$title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center),
        ),
        generateSubtitle(),
        Container(
            margin: EdgeInsets.all(5.0),
            width: double.infinity,
            child: Row(children: <Widget>[
              ComparisionItemWidget(futurePastData, false, formatter),
              ComparisionItemWidget(futureCurrentData, futureCounter, formatter),
            ])),
      ],
    );
  }
}
