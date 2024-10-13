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
  late bool _showChart = false;

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
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TransactionForm(
                onSubmit: _addTransaction,
              ),
            ],
          ),
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
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var appBar = AppBar(
      title: Text(
        'My Expenses',
        style: TextStyle(
          // The scale of the user have set on accessibility options on his device multiplied by 10
          // The new textScalerOf now implements the new non-linear scaleFactor
          fontSize: 18 * MediaQuery.textScalerOf(context).scale(1),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      actions: [
        if (isLandscape && _recentTransactions.isNotEmpty)
          IconButton(
            icon: _showChart
                ? const Icon(Icons.hide_source)
                : const Icon(Icons.bar_chart_outlined),
            onPressed: () {
              // toggle true or false
              setState(() {
                _showChart = !_showChart ? true : false;
              });
            },
          ),
        IconButton(
          icon: _pressed == true
              ? const Icon(Icons.dark_mode_outlined)
              : const Icon(Icons.light_mode_outlined),
          onPressed: () => _changeTheme(),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // if (isLandscape && _recentTransactions.isNotEmpty)
            //   Container(
            //     padding: const EdgeInsets.all(4),
            //     color: Theme.of(context).colorScheme.primary,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Text(
            //           _showChart == false
            //               ? 'Exibir Gráfico'
            //               : 'Esconder Gráfico',
            //           style: TextStyle(
            //             color: Theme.of(context).colorScheme.onPrimary,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            //           child: Switch(
            //             value: _showChart,
            //             onChanged: (value) {
            //               setState(() {
            //                 _showChart = value;
            //               });
            //             },
            //             inactiveTrackColor:
            //                 Theme.of(context).colorScheme.primary,
            //             activeColor: Theme.of(context).colorScheme.onPrimary,
            //             thumbColor: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //               if (states.contains(WidgetState.selected)) {
            //                 return Theme.of(context).colorScheme.primary;
            //               } else {
            //                 return Theme.of(context).colorScheme.surface;
            //               }
            //             }),
            //             inactiveThumbColor:
            //                 Theme.of(context).colorScheme.onPrimary,
            //             trackOutlineColor:
            //                 WidgetStateProperty.resolveWith<Color?>(
            //                     (Set<WidgetState> states) {
            //               if (states.contains(WidgetState.selected)) {
            //                 return null;
            //               } else {
            //                 return Theme.of(context).colorScheme.onPrimary;
            //               }
            //             }),
            //             activeTrackColor: Theme.of(context).colorScheme.surface,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            if (_showChart || !isLandscape && _recentTransactions.isNotEmpty)
              Chart(
                recentTransactions: List.from(_recentTransactions),
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
      floatingActionButtonLocation:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? FloatingActionButtonLocation.centerFloat
              : FloatingActionButtonLocation.endFloat,
    );
  }
}
