import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _input_title = TextEditingController();
  final _input_amount = TextEditingController();
  late DateTime _selectedDate;
  bool _checkselecteddate=false;
  void submit_data(){
    final entered_title=_input_title.text;
    final enteres_amount=double.parse(_input_amount.text.toString());
    if(entered_title.isEmpty || enteres_amount<=0){return;}
    widget.addtx(_input_title.text, double.parse(_input_amount.text),_selectedDate);
    Navigator.of(context).pop();
  }
  void _presentDatepicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022),lastDate: DateTime.now()).then((pickedDate) {
      if(pickedDate==Null){
        return;
      }
      setState(() {
        _checkselecteddate=true;
        _selectedDate=pickedDate!;
      });
    });
  }
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _input_title,
              onSubmitted: (_)=>submit_data(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: _input_amount,
              onSubmitted: (_)=>submit_data(),
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_checkselecteddate==false?"Choose Date":DateTimeFormat.format(_selectedDate, format: 'd/m/Y')),
              IconButton(onPressed: _presentDatepicker, icon:Icon(Icons.calendar_month_outlined))
            ],),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                ),
                onPressed: submit_data,
                child: Text(
                  "ADD TRANSACTION",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: 'Quicksand',fontSize: 15),

                ))
          ],
        ),
      ),
    );
  }
}
