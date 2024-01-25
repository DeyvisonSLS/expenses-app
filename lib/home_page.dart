import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/theme_provider.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// All transactions
class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];

  // Filtered transactions: Only the last week transactions
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      // Add to the list _recentTransactions only the past 7 days from now
      return tr.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _pressed = false;

  _addTransaction(String title, double value, DateTime dateSelected) {
    final newTransaction = Transaction(
      id: Random().nextInt(200),
      title: title,
      value: value,
      date: dateSelected,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  _changeTheme() {
    // widget.themeProvider.toggleTheme();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      themeProvider.toggleTheme();
      _pressed = !_pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text('My Expenses'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.add),
        //   onPressed: () => _openTransactionFormModal(context),
        // ),
        IconButton(
          icon: _pressed == true
              ? const Icon(Icons.dark_mode_outlined)
              : const Icon(Icons.light_mode_outlined),
          onPressed: () => _changeTheme(),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
              recentTransactions: List.from(_recentTransactions.reversed),
            ),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
