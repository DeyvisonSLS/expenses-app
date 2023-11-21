import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              // onChanged: (newValue) => title = newValue,
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              // onChanged: (newValue) => value = newValue,
              controller: valueController,
              decoration: const InputDecoration(labelText: 'Value (R\$)'),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: TextButton(
                onPressed: () {
                  final title = titleController.text;
                  final value = double.tryParse(valueController.text) ?? 0;
                  onSubmit(title, value);
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
      ),
    );
  }
}
