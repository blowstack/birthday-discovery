import 'dart:async';
import 'package:birthday_discovery/widgets/circularLoaderWidget.dart';
import 'package:flutter/material.dart';

class ComparisionItemWidget extends StatefulWidget {
  final formatter;
  final data;
  final futureCounter;

  ComparisionItemWidget(this.data, this.futureCounter, this.formatter);

  @override
  _ComparisionItemWidgetState createState() => _ComparisionItemWidgetState();
}

class _ComparisionItemWidgetState extends State<ComparisionItemWidget> {

  Timer _timer;
  var _value = 1;

  void _startCounter(var start, var step, int frequency) {

    _value = start;

    _timer = new Timer.periodic(
      Duration(milliseconds: frequency),
      (Timer timer) => setState(
        () {
          if (_value < 1) {
            timer.cancel();
          } else {
            _value += step;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: FutureBuilder(
            future: widget.data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (_value == 1 && widget.futureCounter) {
                  _startCounter(snapshot.data['start'], snapshot.data['step'], snapshot.data['frequency']);
                } else if (widget.futureCounter == false) {
                  _value = (snapshot.data).toInt();
                }
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("${widget.formatter.format(_value)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                );
              } else {
                return CircularLoaderWidget(20, 20, 5);
              }
            }),
      ),
    );
  }
}
