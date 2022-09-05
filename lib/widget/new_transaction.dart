import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final input_title = TextEditingController();

  final input_amount = TextEditingController();

  void submit_data(){
    final entered_title=input_title.text;
    final enteres_amount=double.parse(input_amount.text.toString());
    if(entered_title.isEmpty || enteres_amount<=0){return;}
    widget.addtx(input_title.text, double.parse(input_amount.text));
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: input_title,
              onSubmitted: (_)=>submit_data(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: input_amount,
              onSubmitted: (_)=>submit_data(),
            ),
            TextButton(
                onPressed: submit_data,
                child: Text(
                  'ADD TRANSACTION',
                  style: TextStyle(color: Colors.deepOrange),

                ))
          ],
        ),
      ),
    );
  }
}
