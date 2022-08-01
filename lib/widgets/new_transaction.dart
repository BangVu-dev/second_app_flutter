import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  const NewTransaction(this.addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onFieldSubmitted: (_) => _submitData(),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) => _submitData(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            TextButton(
              onPressed: _submitData,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
