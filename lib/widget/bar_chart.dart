import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spending_percentage_total;

  Bar(this.label, this.spendingAmount, this.spending_percentage_total);

  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('\₹${spendingAmount.toStringAsFixed(0)}')),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 15,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepOrange, width: 1),
                    color: Colors.deepOrange),
              ),
              FractionallySizedBox(
                heightFactor: spending_percentage_total,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
