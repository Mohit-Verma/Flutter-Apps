import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        bool isDay = (recentTransactions[i].timeStamp.day == weekDay.day) &&
            (recentTransactions[i].timeStamp.month == weekDay.month) &&
            (recentTransactions[i].timeStamp.year == weekDay.year);
        totalAmount += isDay ? recentTransactions[i].amount : 0.0;
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((dailyExpenses) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day: dailyExpenses['day'],
                amount: dailyExpenses['amount'],
                ratio: totalSpending == 0.0
                    ? 0.0
                    : (dailyExpenses['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
