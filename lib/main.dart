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
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromRGBO(81, 222, 154, 1),
        ),
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

  void _addnewtransaction(String title, double amount,DateTime selected_date) {
    final newtx = Transaction(
        title: title,
        id: DateTime.now().toString(),
        date: selected_date,
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
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx){return tx.id==id;});
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
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Statistics",style: TextStyle(fontSize: 32,fontFamily: 'Quicksand',fontWeight:FontWeight.bold,color:Color.fromRGBO(29, 42, 48, 1)),),
          actions: [
            IconButton(onPressed: () {
              _startaddnewtransaction(context);
            }, icon: Icon(Icons.add), color: Theme.of(context).colorScheme.secondary,)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Chart(_recentTransaction),
              Transactionlist(_userTransactions,_deleteTransaction),
            ],
          ),
        ));
  }
}
