import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './bar_chart.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get grouptransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          sum += recentTransactions[i].amount;
        }
      }
      print(DateTimeFormat.format(weekday, format: 'D'));
      print(sum);
      return {
        'day': DateTimeFormat.format(weekday, format: 'D'),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get maxspending {
    return grouptransaction.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: grouptransaction.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: Bar(
                        (data['day'] as String),
                        (data['amount'] as double),
                        maxspending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / maxspending));
              }).toList()),
        ));
  }
}
