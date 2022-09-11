import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:date_time_format/date_time_format.dart';

class Transactionlist extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletetx;
  Transactionlist(this.transaction,this.deletetx);

  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: transaction.isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: Image.network(
                          'https://thumbs.dreamstime.com/b/transaction-history-rgb-color-icon-e-wallet-application-mobile-banking-app-using-payment-bill-checking-payments-report-isolated-194875666.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Helps you to track your expenses.",style: TextStyle(fontSize: 32,fontFamily: "Quicksand",fontWeight: FontWeight.bold),textAlign:TextAlign.center,),
                      SizedBox(height: 90,),
                      Text("Add Transaction",style: TextStyle(fontSize: 20,fontFamily: "Quicksand",fontWeight: FontWeight.bold,color: Colors.blueGrey))
                    ],
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    margin: EdgeInsets.all(5),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        transaction[index].title,
                        style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateTimeFormat.format(transaction[index].date,
                            format: 'j D Y'),
                        style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                      ),
                      leading: Container(
                        padding: EdgeInsets.only(top: 8),
                        height: 50,
                        child: Card(
                          elevation: 0,
                          child: Text(
                            '\-₹${transaction[index].amount}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ),
                      trailing: IconButton(onPressed: ()=>deletetx(transaction[index].id), icon: Icon(Icons.delete,color: Colors.red,),),
                    ),
                  );
                },
                itemCount: transaction.length,
              ));
  }
}
