import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenses/components/transaction_card.dart';
import 'package:expenses/home_page.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(int) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showChart
          ? (MediaQuery.of(context).size.height -
                  Scaffold.of(context).appBarMaxHeight!.toDouble()) *
              0.75
          : (MediaQuery.of(context).size.height -
              Scaffold.of(context).appBarMaxHeight!.toDouble()),
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'Nenhuma transação cadastrada.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.4,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                        opacity:
                            Theme.of(context).brightness == Brightness.light
                                ? const AlwaysStoppedAnimation(0.25)
                                : const AlwaysStoppedAnimation(0.50),
                      ),
                    ),
                  ],
                );
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return index == 0
                      // When it's the first item, we instantiate a card with a margin at the top
                      ? Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: TransactionCard(
                            transaction: tr,
                            onRemove: onRemove,
                          ),
                        )
                      : TransactionCard(
                          transaction: tr,
                          onRemove: onRemove,
                        );
                },
              ),
            ),
    );
  }
}
