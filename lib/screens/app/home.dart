// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lutta_money_tracker/controller/transactions_controller.dart';
import 'package:lutta_money_tracker/screens/app/create_transaction_pop.dart';
import 'package:lutta_money_tracker/utils/constants.dart';
import 'package:lutta_money_tracker/widgets/app_button.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    TransactionsNotifier transactionsNotifierListen =
        context.watch<TransactionsNotifier>();
    List transactionList = transactionsNotifierListen.transactionList;

   

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(
          children: [
            TotalsCard(transactionList: transactionList,),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: AppButton(
                name: 'Add a Transaction',
                onTap: () {
                  createTransactionDialog(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Transactions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              children: [
                SortButton(
                  name: 'Money In',
                ),
                SortButton(
                  name: 'Money Out',
                ),
                Expanded(
                  child: Card(
                    elevation: 1,
                    child: Center(
                      child: Text('Clear'),
                    ),
                  ),
                ),
              ],
            ),
            for (Map<String, dynamic> transaction in transactionList)
              TransactionTile(
                date: transaction['date'],
                amount: transaction['amount'],
                category: transaction['category'],
                title: transaction['title'],
                isExpense: transaction['isExpense'],
              ),
          ],
        ),
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  final String name;
  const SortButton({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              name.toLowerCase().contains('out')
                  ? Icon(
                      Icons.arrow_downward,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.green,
                    ),
              SizedBox(width: 8.0),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final int amount;
  final String category;
  final String title;
  final String date;
  final bool isExpense;
  const TransactionTile({
    super.key,
    required this.amount,
    required this.category,
    required this.title,
    required this.isExpense,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String amoun = NumberFormat('#,##0').format(amount);
    return Card(
      elevation: 0.5,
      child: ListTile(
        title: Row(
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            Container(
                margin: EdgeInsets.only(left: 8),
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 6),
                decoration: BoxDecoration(
                  color: blueColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(29.0),
                  border: Border.all(
                    color: blueColor,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                      fontSize: 9,
                      color: blueColor,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
        subtitle: Text(
          date,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        onTap: () {},
        leading: Icon(
          Icons.movie_creation_outlined,
          color: Colors.grey,
        ),
        trailing: Text(
          isExpense ? '-$amoun' : '+$amoun',
          style: TextStyle(
            color: isExpense ? Color(0xfff7282a) : greenColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class TotalsCard extends StatefulWidget {
  final List transactionList;
  const TotalsCard({
    super.key, required this.transactionList,
  });

  @override
  State<TotalsCard> createState() => _TotalsCardState();
}

class _TotalsCardState extends State<TotalsCard> {

  

  @override
  Widget build(BuildContext context) {
     int expensesTotal = 0;
  int earningsTotal = 0;
 

     for (var transaction in widget.transactionList) {
      if (!transaction['isExpense']) {
        earningsTotal += transaction['amount'] as int;
      } else{
         expensesTotal += transaction['amount'] as int;
      }

    }
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
     
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blueColor.withOpacity(0.1),
            offset: Offset(2, 2),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardSubtitle(
                    'Total earnings',
                  ),
                  SizedBox(height: 5.0),
                  moneyTitle('+$earningsTotal'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardSubtitle(
                    'Total spending',
                  ),
                  SizedBox(height: 5.0),
                  moneyTitle('-$expensesTotal'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text moneyTitle(String amount) {
    bool isAdd = amount.contains('+');
    return Text(
      'KSH $amount',
      style: TextStyle(
        color: isAdd ? greenColor : Color(0xfff7282a),
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text cardSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
          color: Colors.grey[600], fontSize: 13.0, fontWeight: FontWeight.w600),
    );
  }
}
