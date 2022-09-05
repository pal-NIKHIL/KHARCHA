import 'package:flutter/material.dart';
import './widget/transaction_list.dart';
import './widget/new_transaction.dart';
import './models/transaction.dart';
import './widget/chart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Quicksand',
      ),
      title: 'Money tracker',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  void _addnewtransaction(String title, double amount) {
    final newtx = Transaction(
        title: title,
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: amount);
    setState(() {
      _userTransactions.add(newtx);
    });
  }

  void _startaddnewtransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addnewtransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () {
          _startaddnewtransaction(context);
        },),
        appBar: AppBar(
          title: Text("Money tracker", style: TextStyle(
              fontFamily: 'Quicksand', fontWeight: FontWeight.bold)),
          actions: [
            IconButton(onPressed: () {
              _startaddnewtransaction(context);
            }, icon: Icon(Icons.add), highlightColor: Colors.cyan,)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Chart(_recentTransaction),
              Transactionlist(_userTransactions),
            ],
          ),
        ));
  }
}
