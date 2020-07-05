import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String label;
  final Function action;
  Option({@required this.label, @required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(label),
        onPressed: action,
      ),
    );
  }
}
