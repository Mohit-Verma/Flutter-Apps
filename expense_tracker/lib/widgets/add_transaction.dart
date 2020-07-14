import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addTxAction;
  AddTransaction(this.addTxAction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleHandler = TextEditingController();
  final amountHandler = TextEditingController();
  DateTime _selectedDateTime;

  void _submitData() {
    if (titleHandler.text == null ||
        titleHandler.text.isEmpty ||
        double.parse(amountHandler.text) < 0 ||
        _selectedDateTime == null) {
      return;
    }
    widget.addTxAction(
      titleHandler.text,
      double.parse(amountHandler.text),
      _selectedDateTime,
    );
    Navigator.of(context).pop();
  }

  void _provideDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDateTime = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleHandler,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountHandler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 80,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: (_selectedDateTime == null)
                        ? Text(
                            'No Date Choosen',
                            style: Theme.of(context).textTheme.headline2,
                          )
                        : Text(
                            DateFormat.yMd().format(_selectedDateTime),
                            style: Theme.of(context).textTheme.headline1,
                          ),
                  ),
                  FlatButton(
                    onPressed: _provideDatePicker,
                    child: Text(
                      'Select Date',
                      style: (_selectedDateTime == null)
                          ? Theme.of(context).textTheme.headline1
                          : Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () => _submitData(),
            )
          ],
        ),
      ),
    );
  }
}
