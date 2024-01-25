import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum SampleItem { details, share, delete }

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final void Function(int) onRemove;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onRemove,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  SampleItem? selectedMenu;

  void _executeSelectedMenuAction() {
    switch (selectedMenu) {
      case SampleItem.details:
        break;
      case SampleItem.delete:
        setState(() {
          widget.onRemove(widget.transaction.id);
        });
        break;
      case SampleItem.share:
        break;
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 2,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 2,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text('R\$${widget.transaction.value}'),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(DateFormat('dd/MM/y').format(widget.transaction.date)),
          trailing: PopupMenuButton<SampleItem>(
            initialValue: selectedMenu,
            onSelected: (SampleItem item) {
              setState(() {
                selectedMenu = item;
                _executeSelectedMenuAction();
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<SampleItem>>[
              const PopupMenuItem(
                value: SampleItem.details,
                child: Text('Details'),
              ),
              const PopupMenuItem(
                value: SampleItem.delete,
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
