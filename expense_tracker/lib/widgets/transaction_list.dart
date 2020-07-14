import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  TransactionList({this.transactions, this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: Container(
                width: 80,
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '₹${transactions[index].amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline1,
              ),
              subtitle: Text(
                DateFormat().add_yMMMd().format(transactions[index].timeStamp),
                style: Theme.of(context).textTheme.headline2,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => removeTransaction(transactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}
