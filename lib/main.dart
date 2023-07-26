// ignore_for_file: prefer_const_constructors

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'New running shoes',
      value: 350.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Electricity Bill',
      value: 150.14,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            color: Colors.amber,
            elevation: 3,
            child: Text('Graphic'),
          ),
          Column(
            children: _transactions.map(
              (tr) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purpleAccent,
                            width: 3,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Text(
                          'R\$ ${tr.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.purpleAccent,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            DateFormat('d MMM y').format(tr.date),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
          Card(
            elevation: 5,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Value (R\$)'),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Add'),
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(16))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
