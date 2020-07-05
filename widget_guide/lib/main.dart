import 'package:flutter/material.dart';
import 'package:widget_guide/quiz.dart';
import 'package:widget_guide/result.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'text': "What's your favourite color?",
      'answers': [
        {'text': 'Black', 'score': 100},
        {'text': 'Red', 'score': 50},
        {'text': 'Green', 'score': 25},
        {'text': 'White', 'score': 0},
      ]
    },
    {
      'text': "What's your favourite animal?",
      'answers': [
        {'text': 'Lion', 'score': 100},
        {'text': 'Horse', 'score': 50},
        {'text': 'Elephant', 'score': 25},
        {'text': 'Rabbit', 'score': 0},
      ]
    },
    {
      'text': "What's your favourite dish",
      'answers': [
        {'text': 'Mexican', 'score': 100},
        {'text': 'chineese', 'score': 50},
        {'text': 'North Indian', 'score': 25},
        {'text': 'South Indian', 'score': 0}
      ]
    }
  ];

  int _pos = 0;
  int _totalScore = 0;

  void _answerSelected(int score) {
    setState(() {
      _pos++;
    });
    _totalScore += score;
    print(_totalScore);
  }

  void _restartGame() {
    setState(() {
      _pos = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My App'),
          ),
          body: (_pos < questions.length)
              ? Quiz(
                  questions: questions,
                  pos: _pos,
                  answerSelected: _answerSelected)
              : Result(
                  restart: _restartGame,
                  totalScore: _totalScore,
                )),
    );
  }
}
