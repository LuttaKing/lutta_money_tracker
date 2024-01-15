// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lutta_money_tracker/controller/transactions_controller.dart';
import 'package:lutta_money_tracker/utils/constants.dart';
import 'package:lutta_money_tracker/utils/functions.dart';
import 'package:lutta_money_tracker/widgets/app_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void createTransactionDialog(BuildContext context) {
  
  String getCurrentMonthYear() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM/yyyy');
    return formatter.format(now);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        TransactionsNotifier transactionsNotifierListen = context.watch<TransactionsNotifier>();

        TransactionsNotifier transactionsNotifier = context.read<TransactionsNotifier>();

        int? amount = transactionsNotifierListen.amount;
        String? catego = transactionsNotifierListen.category;
        String? title = transactionsNotifierListen.title;

        bool? isExpense = transactionsNotifierListen.isExpense;
     

        return AlertDialog(
          title: Center(
              child: Text(
            'Add a Transaction',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          )),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (v) {
                    transactionsNotifier.updateTitle(v);
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Wrap(
                    spacing: 5.0,
                    children: Categories.values.map((category) {
                      return InkWell(
                        onTap: () {
                          transactionsNotifier.updateCategory(
                              category.toString().split('.').last);
                        },
                        child: Chip(
                          backgroundColor:
                              catego == category.toString().split('.').last
                                  ? blueColor.withOpacity(0.5)
                                  : null,
                          labelPadding: EdgeInsets.all(2),
                          padding: EdgeInsets.all(2),
                          label: Text(
                            category.toString().split('.').last,
                            style: TextStyle(letterSpacing: 0.4, fontSize: 12,color: catego == category.toString().split('.').last
                                  ? Colors.white : null),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Adjust this value to control the corner radius
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                TextField(
                  onChanged: (v) {
                  transactionsNotifier.updateAmount(int.parse(v));
                  },
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
                SizedBox(
                  child: Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile<bool>(contentPadding: EdgeInsets.all(2),
                        title: Text('is Expense'),
                        value: true,
                        groupValue: isExpense,
                        onChanged: (value) {
                          isExpense = transactionsNotifier.updateExpense(value!);
                        },
                      ),
                      RadioListTile<bool>(contentPadding: EdgeInsets.all(2),
                        title: Text('not Expense'),
                        value: false,
                        groupValue: isExpense,
                        onChanged: (value) {
                          isExpense = transactionsNotifier.updateExpense(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            AppButton(
                name: 'Create',
                onTap: () {
                  if (title == null || isExpense == null || catego == null) {
                    print(title);
                    print(isExpense);
                    print(amount);
                    print(catego);

                    //print(getCurrentMonthYear());
                    notifyUser(context, 'Fill and Select all fields', Colors.red);
                  } else {


            Map<String,dynamic> transaction = {
      'title': title,
      'category': catego,
      'amount': amount,
      'isExpense': isExpense,
      'date': getCurrentMonthYear()
    };
                    transactionsNotifier.addTransactionToList(transaction);
                    Navigator.pop(context);
                  }
                }),
            SizedBox(
              height: 10,
            ),
            AppButton(
              name: 'Cancel',
              onTap: () => Navigator.pop(context),
              color: Colors.red,
            ),
          ],
        );
      });
}
