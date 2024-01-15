import 'package:flutter/material.dart';

enum Categories {
  entertainment,
  work,
  family,
  transport,
  food,
  emergency,
  frd,
  miscellaneous,
  waste,
  dates,
}

class TransactionsNotifier extends ChangeNotifier {
  int? amount;
  String? category;
  String? title;
  String? date;
  bool? isExpense;

  List<Map<String, dynamic>> transactionList = [
    {
      'title': 'Netflix Payment RenderFlex overflowed by',
      'category': Categories.entertainment.name,
      'amount': 1200,
      'isExpense': true,
      'date': 'January,2023'
    },
    {
      'title': 'Telegram shii',
      'category': Categories.frd.name,
      'amount': 2300,
      'isExpense': false,
      'date': 'January,2023'
    },
    {
      'title': 'Work (Freelance)',
      'category': Categories.work.name,
      'amount': 456,
      'isExpense': false,
      'date': 'January,2023'
    },
  ];

  addTransactionToList(Map<String, dynamic> transaction) {
    transactionList.add(transaction);
    amount = null;
    title= null;
    category= null;
    date= null;
    isExpense= null;
    notifyListeners();
  }

  

  updateCategory(String c) {
    category = c;
    notifyListeners();
  }

  updateTitle(String c) {
    title = c;
    notifyListeners();
  }

  updateDate(String c) {
    date = c;
    notifyListeners();
  }

  updateAmount(int c) {
    amount = c;
    notifyListeners();
  }

  updateExpense(bool c) {
    isExpense = c;
    notifyListeners();
  }
}
