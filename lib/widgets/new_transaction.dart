import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';
import './utils.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() {
    print('createstate newtransaction widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('constructor newtransaction state');
  }

  @override
  void initState() {
    super.initState();
    print('initState()');
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget()');
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _handleAddTransaction() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        !(double.parse(_amountController.text) < 0) &&
        _selectedDate != null) {
      widget._addTransaction(
        _titleController.text,
        double.parse(_amountController.text),
        _selectedDate,
      );
      _titleController.text = '';
      _amountController.text = '';
      unfocus(context);

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom +
                10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                onSubmitted: (_) => _handleAddTransaction(),
              ),
              Container(
                height: 70.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate != null
                            ? 'Date: ${DateFormat.yMd().format(_selectedDate)}'
                            : 'No Date Chosen',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              AdaptiveRaisedButton(
                buttonText: 'Add Transaction',
                handleTap: _handleAddTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
