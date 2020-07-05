import 'package:flutter/material.dart';
import './question.dart';
import 'option.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int pos;
  final Function answerSelected;

  Quiz({
    @required this.questions,
    @required this.pos,
    @required this.answerSelected,
  });

  List<Option> getAvailableOptions() {
    return (questions[pos]['answers'] as List<Map<String, Object>>)
        .map((answer) => Option(
              action: () => answerSelected(answer['score']),
              label: answer['text'],
            ))
        .toList();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questions[pos]['text']),
        ...getAvailableOptions(),
      ],
    );
  }
}
