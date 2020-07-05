import 'package:flutter/material.dart';
import 'package:widget_guide/option.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
  final int totalScore;
  final Function restart;
  MaterialColor _resultHighlighter;
  Result({@required this.totalScore, @required this.restart});

  String get resultText {
    if (totalScore == 0) {
      _resultHighlighter = Colors.green;
      return 'You are awesome and innocent';
    } else if (totalScore > 0 && totalScore <= 75) {
      _resultHighlighter = Colors.lightGreen;
      return 'Pretty Likeable';
    } else if (totalScore > 75 && totalScore <= 150) {
      _resultHighlighter = Colors.grey;
      return 'You are... Strange?!';
    } else {
      _resultHighlighter = Colors.orange;
      return 'You are bad';
    }
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultText,
            style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.normal,
                color: _resultHighlighter),
          ),
          Option(label: 'Restart', action: restart)
        ],
      ),
    );
  }
}
