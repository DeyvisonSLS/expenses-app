import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  void _submitForm() {
    final String title;
    final double value;

    if (titleController.text.isNotEmpty || valueController.text.isNotEmpty) {
      title = titleController.text;
      value = double.tryParse(valueController.text) ?? 0;
    } else {
      return;
    }

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            // onChanged: (newValue) => title = newValue,
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            // onChanged: (newValue) => value = newValue,
            controller: valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(labelText: 'Value (R\$)'),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: TextButton(
              onPressed: () {
                _submitForm();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(16),
                ),
              ),
              child: const Text('Add'),
            ),
          )
        ],
      ),
    );
  }
}
