import 'package:flutter/material.dart';

import './model/transaction.dart';
import './model/dimension.dart';
import './widgets/transaction_list.dart';
import './widgets/add_transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.black,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'QuickSand',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
              headline2: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.timeStamp.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime dateTime) {
    setState(() {
      _transactions.add(Transaction(
        id: 't${_transactions.length}',
        title: title,
        amount: amount,
        timeStamp: dateTime,
      ));
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return AddTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showTransactionForm(context),
        )
      ],
    );
    final Dimension dimension = Dimension(
      context: context,
      appBarDimension: appBar.preferredSize,
      statusBarDimension: MediaQuery.of(context).padding,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: _transactions.isEmpty
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: dimension.getAvailableHeight() * 0.1,
                    ),
                    Container(
                      height: dimension.getAvailableHeight() * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: dimension.getAvailableHeight() * 0.1,
                    ),
                    Text(
                      'No transactions to display!',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: dimension.isPortraitMode()
                          ? dimension.getAvailableHeight() * 0.3
                          : 0,
                      child: Chart(_recentTransactions),
                    ),
                    Container(
                      height: dimension.isPortraitMode()
                          ? dimension.getAvailableHeight() * 0.7
                          : dimension.getAvailableHeight() * 1,
                      child: TransactionList(
                        transactions: _transactions,
                        removeTransaction: _removeTransaction,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionForm(context),
        tooltip: 'Floating Widget',
        child: Icon(Icons.add),
      ),
    );
  }
}
