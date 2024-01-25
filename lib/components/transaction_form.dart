import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  late DateTime? dateTimeSelected = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    final String title;
    final double value;
    final DateTime date;

    if (titleController.text.isNotEmpty ||
        valueController.text.isNotEmpty ||
        dateTimeSelected != null) {
      title = titleController.text;
      value = double.tryParse(valueController.text) ?? 0;
      date = dateTimeSelected as DateTime;
    } else {
      return;
    }

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, date);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, put some title.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    // errorText: "Please, put some title.",
                  ),
                ),
                TextFormField(
                  controller: valueController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Value (R\$)',
                    // errorText: "Please, put some value.",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, put some value.';
                    }
                    return null;
                  },
                ),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date of Transaction',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please, select some date.';
                    }
                    dateTimeSelected = value;
                    return null;
                  },
                  initialPickerDateTime: DateTime(2019),
                  lastDate: DateTime.now(),
                  initialValue: DateTime.now(),
                  mode: DateTimeFieldPickerMode.date,
                  onChanged: (DateTime? value) => dateTimeSelected = value,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm().then(
                          (value) {
                            return Fluttertoast.showToast(
                              msg: "Transaction added!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          },
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Some fields needs attention. Review the form.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                        );
                      }
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
        ),
      ],
    );
  }
}
