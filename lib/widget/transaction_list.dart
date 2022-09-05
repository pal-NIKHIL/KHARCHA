import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:date_time_format/date_time_format.dart';

class Transactionlist extends StatelessWidget {
  final List<Transaction> transaction;

  Transactionlist(this.transaction);

  Widget build(BuildContext context) {
    return Container(
      height: 400,
        child: transaction.isEmpty?Column(children: [
          SizedBox(height: 10,),
          Container(height:300,child: Image.network('https://i.pinimg.com/originals/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.png',fit: BoxFit.cover,))
        ],):ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
            child: Row(
          children: <Widget>[
            Container(
              child: Text(
                '\₹ ${transaction[index].amount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 3)),
              padding: EdgeInsets.all(10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction[index].title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  DateTimeFormat.format(transaction[index].date,
                      format: 'D ,  j M'),
                  style: TextStyle(fontSize: 15, color: Colors.black26),
                )
              ],
            )
          ],
        ));
      },
      itemCount: transaction.length,
    ));
  }
}
